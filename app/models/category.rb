class Category
  include KonmegoNeo4jNode

  property :id, type: Integer
  property :category, type: String
  property :name, type: String

end
