class ForceCreateTopicUuidConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :Topic, :uuid, force: true
  end

  def down
    drop_constraint :Topic, :uuid
  end
end
