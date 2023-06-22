class Endorse
  include ActiveGraph::Relationship

  from_class :Person
  to_class   :Person
  type 'ENDORSES'
  creates_unique on: [:topic]

  property :topic
  property :topic_id
  property :description
  enum status: [:pending, :accepted, :declined], _default: :pending
  enum topic_status: [:proposed, :existing], _default: :proposed

  validates_presence_of :topic
  
  def endorser_avatar_url
    from_node.avatar_url
  end

  def endorsee_avatar_url
    to_node.avatar_url
  end

  def endorsee_name
    to_node.name
  end

  def endorser_name
    from_node.name
  end

end
