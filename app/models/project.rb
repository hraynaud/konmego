class Project 
  include Neo4j::ActiveNode

  property :name, type: String
  property :description, type: String
  property :start_date, type: Date
  property :end_date, type: Date

end
