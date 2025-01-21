class ForceCreateSuccessCriteriumUuidConstraint < ActiveGraph::Migrations::Base
  def up
    add_constraint :SuccessCriterium, :uuid, force: true
  end

  def down
    drop_constraint :SuccessCriterium, :uuid
  end
end
