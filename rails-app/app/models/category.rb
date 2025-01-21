class Category
  include KonmegoNeo4jNode

  property :id, type: Integer
  property :name, type: String
  property :description, type: String
end
