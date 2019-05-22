class Person 
  include Neo4j::ActiveNode
  property :id, type: Integer
  property :name, type: String



end
