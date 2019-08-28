class SuccessCriterium
  include Neo4j::ActiveNode

  property :description, type: String
  property :notes, type: String
  has_one :in, :project, type: :NEEDS
end
