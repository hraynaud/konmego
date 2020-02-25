class ForceCreateEndorsementStatusIndex < Neo4j::Migrations::Base
  def up
    add_index :Endorsement, :status, force: true
  end

  def down
    drop_index :Endorsement, :status
  end
end
