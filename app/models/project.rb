class Project 
  include Neo4j::ActiveNode

  property :name, type: String
  property :description, type: String
  property :start_date, type: Date
  property :end_date, type: Date

  has_one :in, :owner, model_class: :Person, type: :OWNED_BY

  validates :owner, :name, :description, presence: true
end

