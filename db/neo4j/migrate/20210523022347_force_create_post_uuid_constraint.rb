class ForceCreatePostUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Post, :uuid, force: true
  end

  def down
    drop_constraint :Post, :uuid
  end
end
