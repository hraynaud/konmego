class ForceCreateEndorsementTypeIndex < Neo4j::Migrations::Base
  def up
    add_index :Endorsement, :type, force: true
  end

  def down
    drop_index :Endorsement, :type
  end
end
