class ForceCreateActivityUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Activity, :uuid, force: true
  end

  def down
    drop_constraint :Activity, :uuid
  end
end
