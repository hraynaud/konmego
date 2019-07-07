class ForceCreatePersonIsMemberIndex < Neo4j::Migrations::Base
  def up
    add_index :Person, :is_member, force: true
  end

  def down
    drop_index :Person, :is_member
  end
end
