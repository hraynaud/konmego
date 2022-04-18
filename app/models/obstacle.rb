class Obstacle
  include KonmegoNeo4jNode

  property :description, type: String
  property :is_cleared, type: Boolean, default: false
  has_one :out, :obstacle_category, type: :obstacle_category
  has_one :in, :project, type: :BLOCKS
end
