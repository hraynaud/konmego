class ForceCreateRegistrationUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :Registration, :uuid, force: true
  end

  def down
    drop_constraint :Registration, :uuid
  end
end
