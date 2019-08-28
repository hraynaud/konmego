class Topic

  include Neo4j::ActiveNode

  property :category, type: String
  property :name, type: String

  has_many :in, :endorsements, origin: :topic
  has_many :in, :projects, origin: :CONCERNS
end
