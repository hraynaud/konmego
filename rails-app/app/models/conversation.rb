class Conversation < ApplicationRecord
  has_many :conversation_participants, dependent: :destroy
  has_many :messages, dependent: :destroy

  validates :conversation_type, presence: true, inclusion: {
    in: %w[direct_message project_chat topic_chat group_chat]
  }
  validates :context_id, presence: true, if: -> { context_type.in?(%w[Project Topic]) }

  enum conversation_type: {
    direct_message: 'direct_message',
    project_chat: 'project_chat',
    topic_chat: 'topic_chat',
    group_chat: 'group_chat'
  }

  scope :active, -> { where(archived_at: nil) }
  scope :recent, -> { order(last_message_at: :desc) }
  scope :for_person, lambda { |person_id|
    joins(:conversation_participants)
      .where(conversation_participants: { person_id: person_id, left_at: nil })
  }

  def participants
    @participants ||= conversation_participants.active
  end

  def participant_people
    @participant_people ||= participants.map(&:person_from_neo4j).compact
  end

  def participant_ids
    conversation_participants.active.pluck(:person_id)
  end

  def can_participate?(user_id)
    case conversation_type
    when 'direct_message', 'group_chat'
      conversation_participants.active.exists?(person_id: user_id)
    when 'project_chat'
      project = context_entity
      return false unless project

      # Project owner and participants can always participate
      return true if project.owner.id == user_id
      return true if project.participants.any? { |p| p.id == user_id }

      # For public projects, anyone can participate
      return true if project.visibility == 'public'

      # For non-public projects, only contacts of project owner can participate
      project_owner = project.owner
      current_user = Person.find(user_id)
      project_owner.contacts.include?(current_user)
    when 'topic_chat'
      true # Generally open to all users
    end
  rescue ActiveGraph::Node::Labels::RecordNotFound
    false
  end

  def can_moderate?(user_id)
    case conversation_type
    when 'direct_message'
      false # No moderation in DMs
    when 'project_chat'
      project = context_entity
      project&.owner&.id == user_id
    when 'topic_chat'
      false # Open discussion
    when 'group_chat'
      conversation_participants.active
                               .where(person_id: user_id)
                               .where(role: %w[admin moderator])
                               .exists?
    end
  end

  def context_entity
    return nil unless context_id && context_type

    case context_type
    when 'Project'
      Project.find(context_id)
    when 'Topic'
      Topic.find(context_id)
    end
  rescue ActiveGraph::Node::Labels::RecordNotFound
    nil
  end

  def display_title
    return title if title.present?

    case conversation_type
    when 'direct_message'
      participant_names = participant_people.map(&:name)
      participant_names.join(' & ')
    when 'project_chat'
      "#{context_entity&.name || 'Project'} Discussion"
    when 'topic_chat'
      "#{context_entity&.name || 'Topic'} Chat"
    when 'group_chat'
      title.presence || 'Group Chat'
    end
  end

  def other_participant(current_user_id)
    return nil unless direct_message?

    other_participant = conversation_participants.active
                                                 .where.not(person_id: current_user_id)
                                                 .first
    other_participant&.person_from_neo4j
  end

  def unread_count_for(user_id)
    messages.joins("LEFT JOIN message_reads ON messages.id = message_reads.message_id
                    AND message_reads.reader_id = '#{user_id}'")
            .where(message_reads: { id: nil })
            .where.not(sender_id: user_id)
            .where(deleted_at: nil)
            .count
  end

  def update_last_message_time!
    touch(:last_message_at)
  end

  def archive!
    update!(archived_at: Time.current)
  end

  def add_participant!(person_id, role: 'member')
    return false unless group_chat? || topic_chat?

    conversation_participants.find_or_create_by(person_id: person_id) do |participant|
      participant.role = role
      participant.joined_at = Time.current
      participant.left_at = nil
    end
  end

  def remove_participant!(person_id)
    participant = conversation_participants.active.find_by(person_id: person_id)
    participant&.update!(left_at: Time.current)
  end

  class << self
    def find_or_create_direct_message(user1_id, user2_id)
      # Look for existing direct message between these users
      conversation = joins(:conversation_participants)
                     .where(conversation_type: 'direct_message')
                     .group(:id)
                     .having('COUNT(conversation_participants.id) = 2')
                     .where(conversation_participants: {
                              person_id: [user1_id, user2_id],
                              left_at: nil
                            })
                     .first

      return conversation if conversation

      # Verify users can message each other
      user1 = Person.find(user1_id)
      user2 = Person.find(user2_id)

      raise StandardError, 'Users cannot message each other' unless can_users_message?(user1, user2)

      # Create new conversation
      transaction do
        conversation = create!(
          conversation_type: 'direct_message',
          last_message_at: Time.current
        )

        conversation.conversation_participants.create!([
                                                         { person_id: user1_id, role: 'member' },
                                                         { person_id: user2_id, role: 'member' }
                                                       ])

        conversation
      end
    end

    def find_or_create_project_chat(project)
      existing = find_by(
        conversation_type: 'project_chat',
        context_type: 'Project',
        context_id: project.id
      )

      return existing if existing

      transaction do
        conversation = create!(
          conversation_type: 'project_chat',
          context_type: 'Project',
          context_id: project.id,
          title: "#{project.name} Discussion",
          last_message_at: Time.current
        )

        # Auto-add project owner as admin
        conversation.conversation_participants.create!(
          person_id: project.owner.id,
          role: 'admin'
        )

        # Auto-add project participants as members
        project.participants.each do |participant|
          conversation.conversation_participants.create!(
            person_id: participant.id,
            role: 'member'
          )
        end

        conversation
      end
    end

    def find_or_create_topic_chat(topic)
      existing = active.find_by(
        conversation_type: 'topic_chat',
        context_type: 'Topic',
        context_id: topic.id
      )

      return existing if existing

      create!(
        conversation_type: 'topic_chat',
        context_type: 'Topic',
        context_id: topic.id,
        title: "#{topic.name} Discussion",
        last_message_at: Time.current
      )
    end

    def create_group_chat(title, creator_id, participant_ids = [])
      transaction do
        conversation = create!(
          conversation_type: 'group_chat',
          title: title,
          last_message_at: Time.current
        )

        # Add creator as admin
        conversation.conversation_participants.create!(
          person_id: creator_id,
          role: 'admin'
        )

        # Add other participants as members
        participant_ids.each do |participant_id|
          next if participant_id == creator_id

          conversation.conversation_participants.create!(
            person_id: participant_id,
            role: 'member'
          )
        end

        conversation
      end
    end

    private

    def can_users_message?(user1, user2)
      # Users can chat if they are:
      # 1. Contacts (friends)
      # 2. Following each other
      # 3. Part of the same project
      # 4. Have endorsed each other

      return true if user1.contacts.include?(user2)
      return true if user1.followings.include?(user2) && user2.followings.include?(user1)

      # Check if they're in the same project
      user1_project_ids = (user1.projects.pluck(:id) + user1.participations.pluck(:id)).uniq
      user2_project_ids = (user2.projects.pluck(:id) + user2.participations.pluck(:id)).uniq
      return true if (user1_project_ids & user2_project_ids).any?

      # Check endorsements
      return true if user1.endorses?(user2) || user2.endorses?(user1)

      false
    end
  end
end
