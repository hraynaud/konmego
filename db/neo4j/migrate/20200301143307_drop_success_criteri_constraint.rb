class DropSuccessCriteriConstraint < Neo4j::Migrations::Base
  def up
    drop_constraint :SuccessCriterium, :uuid
  end

  def down
    raise Neo4j::IrreversibleMigration
  end
end
