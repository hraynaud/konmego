class ForceCreateObstacleUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Obstacle, :uuid, force: true
  end

  def down
    drop_constraint :Obstacle, :uuid
  end
end
