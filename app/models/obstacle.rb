class Obstacle
  include KonmegoNeo4jNode

  property :description, type: String
  property :is_cleared, type: Boolean, default: false
  #TODO  obstacles should have some kind of category of classification.
  #property :category, type: String
  has_one :in, :project, type: :BLOCKS
end
