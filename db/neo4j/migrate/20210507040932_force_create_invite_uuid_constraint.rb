class ForceCreateInviteUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Invite, :uuid, force: true
  end

  def down
    drop_constraint :Invite, :uuid
  end
end
