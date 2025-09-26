class Message < ApplicationRecord
  belongs_to :conversation
  has_many :message_reads, dependent: :destroy
  belongs_to :reply_to, class_name: 'Message', optional: true
  has_many :replies, class_name: 'Message', foreign_key: 'reply_to_id'

  validates :sender_id, presence: true, unless: -> { message_type == 'system' }
  validates :content, presence: true, unless: -> { deleted_at.present? }
  validates :message_type, inclusion: { in: %w[text image file system] }

  enum message_type: { text: 'text', image: 'image', file: 'file', system: 'system' }

  scope :undeleted, -> { where(deleted_at: nil) }
  scope :recent, -> { order(created_at: :desc) }
  scope :chronological, -> { order(created_at: :asc) }
  scope :unread_by, lambda { |user_id|
    left_joins(:message_reads)
      .where(message_reads: { reader_id: nil })
      .where.not(sender_id: user_id)
      .where(deleted_at: nil)
      .or(
        left_joins(:message_reads)
          .where.not(message_reads: { reader_id: user_id })
          .where.not(sender_id: user_id)
          .where(deleted_at: nil)
      )
  }

  after_create :update_conversation_timestamp
  after_create :broadcast_message
  after_create :ensure_sender_is_participant

  def sender_from_neo4j
    return nil if message_type == 'system'

    @sender_from_neo4j ||= Person.find(sender_id)
  rescue ActiveGraph::Node::Labels::RecordNotFound
    nil
  end

  def mark_as_read!(user_id)
    return if sender_id == user_id
    return if message_type == 'system'

    message_reads.find_or_create_by(reader_id: user_id) do |read|
      read.read_at = Time.current
    end
  end

  def read_by?(user_id)
    return true if sender_id == user_id
    return true if message_type == 'system'

    message_reads.exists?(reader_id: user_id)
  end

  def can_edit?(user_id)
    sender_id == user_id &&
      created_at > 15.minutes.ago &&
      deleted_at.nil?
  end

  def can_delete?(user_id)
    sender_id == user_id ||
      conversation.can_moderate?(user_id)
  end

  def soft_delete!
    update!(
      deleted_at: Time.current,
      content: '[Message deleted]'
    )
  end

  def edit_content!(new_content, user_id)
    return false unless can_edit?(user_id)

    update!(
      content: new_content,
      edited_at: Time.current
    )
  end

  def display_content
    deleted_at? ? '[Message deleted]' : content
  end

  def as_json(options = {})
    current_user_id = options[:current_user_id]
    sender = sender_from_neo4j

    super(options.except(:current_user_id)).merge(
      sender_name: sender&.name,
      sender_avatar: sender&.avatar_url,
      sender_id: sender&.id,
      conversation_id: conversation.id,
      reply_to_id: reply_to_id,
      can_edit: current_user_id ? can_edit?(current_user_id) : false,
      can_delete: current_user_id ? can_delete?(current_user_id) : false,
      is_read: current_user_id ? read_by?(current_user_id) : false,
      display_content: display_content
    )
  end

  private

  def update_conversation_timestamp
    conversation.update_last_message_time!
  end

  def broadcast_message
    ChatChannel.broadcast_to(
      conversation,
      {
        type: 'new_message',
        message: as_json,
        conversation_id: conversation.id
      }
    )
  end

  def ensure_sender_is_participant
    return if message_type == 'system'
    return if sender_id.blank?

    # Auto-join topic chats when sending first message
    if conversation.topic_chat? && !conversation.conversation_participants.exists?(person_id: sender_id)
      conversation.conversation_participants.create!(
        person_id: sender_id,
        role: 'member',
        joined_at: Time.current
      )
    end

    # For project chats, ensure the sender is still an active participant
    # (in case they were removed from the project but conversation still exists)
    return unless conversation.project_chat?

    project = conversation.context_entity
    return unless project && (project.owner.id == sender_id || project.participants.any? { |p| p.id == sender_id })
    # Ensure they're in the conversation participants
    return if conversation.conversation_participants.active.exists?(person_id: sender_id)

    role = project.owner.id == sender_id ? 'admin' : 'member'
    conversation.conversation_participants.create!(
      person_id: sender_id,
      role: role,
      joined_at: Time.current
    )
  end
end
