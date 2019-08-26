class ForceCreateProjectStatusIndex < Neo4j::Migrations::Base
  def up
    add_index :Project, :status, force: true
  end

  def down
    drop_index :Project, :status
  end
end
