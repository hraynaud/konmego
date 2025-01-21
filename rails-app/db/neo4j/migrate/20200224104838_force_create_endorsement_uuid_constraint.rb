class ForceCreateEndorsementUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Endorsement, :uuid, force: true
  end

  def down
    drop_constraint :Endorsement, :uuid
  end
end
