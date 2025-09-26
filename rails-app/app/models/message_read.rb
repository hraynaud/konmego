class MessageRead < ApplicationRecord
  belongs_to :message

  validates :reader_id, presence: true, uniqueness: { scope: :message_id }
  validates :read_at, presence: true

  def reader_from_neo4j
    @reader_from_neo4j ||= Person.find(reader_id)
  rescue ActiveGraph::Node::Labels::RecordNotFound
    nil
  end
end
