class Topic

  include Neo4j::ActiveNode

  property :category, type: String
  property :name, type: String

  has_many :in, :endorsements, origin: :topic
end
