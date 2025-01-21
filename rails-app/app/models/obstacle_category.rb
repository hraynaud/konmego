class ObstacleCategory
  include KonmegoNeo4jNode

  property :id, type: Integer
  property :description, type: String
  property :name, type: String
  has_many :in, :obstacle, type: :obstacle
end
