class ForceCreateProjectUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Project, :uuid, force: true
  end

  def down
    drop_constraint :Project, :uuid
  end
end
