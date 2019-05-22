class CreatePerson < Neo4j::Migrations::Base
  def up
    add_constraint :Person, :uuid
  end

  def down
    drop_constraint :Person, :uuid
  end
end
