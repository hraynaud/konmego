class Endorse
  include ActiveGraph::Relationship

  from_class :Person
  to_class   :Person
  type 'ENDORSES'

  property :topic
  property :description
  enum status: [:pending, :accepted, :declined], _default: :pending

  validates_presence_of :topic


end
