class RelabelEndorsementRelations < ActiveGraph::Migrations::Base
  def up
    relabel_relation :ENDORSE_SOURCE, :ENDORSEMENT_SOURCE
    relabel_relation :ENDORSE_TARGET, :ENDORSEMENT_TARGET

  end

  def down
    raise Neo4j::IrreversibleMigration
  end
end
