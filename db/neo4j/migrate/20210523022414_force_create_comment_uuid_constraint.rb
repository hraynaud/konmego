class ForceCreateCommentUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Comment, :uuid, force: true
  end

  def down
    drop_constraint :Comment, :uuid
  end
end
