class Activity 
  include KonmegoNeo4jNode 
  has_one :out, :project, type: nil
end
