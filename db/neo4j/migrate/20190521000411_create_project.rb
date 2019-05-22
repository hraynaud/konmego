class CreateProject < Neo4j::Migrations::Base
  def up
    add_constraint :Project, :uuid
  end

  def down
    drop_constraint :Project, :uuid
  end
end
