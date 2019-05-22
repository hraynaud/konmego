class Topic 
  include Neo4j::ActiveNode
  property :id, type: Integer
  property :category, type: String
  property :name, type: String



end
