class ForceCreateObstacleCategoryUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :ObstacleCategory, :uuid, force: true
  end

  def down
    drop_constraint :ObstacleCategory, :uuid
  end
end
