class ForceCreateProjectStatusIndex < ActiveGraph::Migrations::Base
  def up
    add_index :Project, :status, force: true
  end

  def down
    drop_index :Project, :status
  end
end
