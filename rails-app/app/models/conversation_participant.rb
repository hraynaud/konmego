class ConversationParticipant < ApplicationRecord
  belongs_to :conversation

  validates :person_id, presence: true, uniqueness: { scope: :conversation_id }
  validates :role, inclusion: { in: %w[member admin moderator] }

  enum role: { member: 'member', admin: 'admin', moderator: 'moderator' }

  scope :active, -> { where(left_at: nil) }

  def person_from_neo4j
    @person_from_neo4j ||= Person.find(person_id)
  rescue ActiveGraph::Node::Labels::RecordNotFound
    nil
  end

  def can_invite_others?
    admin? || moderator? || conversation.group_chat?
  end

  def can_remove_others?
    admin? || (moderator? && conversation.group_chat?)
  end

  def leave!
    update!(left_at: Time.current)
  end

  def rejoin!
    update!(left_at: nil, joined_at: Time.current)
  end
end
