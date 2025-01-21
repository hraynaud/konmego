class ForceCreateProjectVisibilityIndex < ActiveGraph::Migrations::Base
  def up
    add_index :Project, :visibility, force: true
  end

  def down
    drop_index :Project, :visibility
  end
end
