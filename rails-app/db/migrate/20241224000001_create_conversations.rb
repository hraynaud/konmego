
class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.string :title
      t.string :conversation_type, null: false
      t.string :context_type # 'Project' or 'Topic' for polymorphic association
      t.string :context_neo4j_id # Neo4j ID of the context entity
      t.datetime :last_message_at
      t.datetime :archived_at
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_index :conversations, :conversation_type
    add_index :conversations, [:context_type, :context_neo4j_id]
    add_index :conversations, :last_message_at
    add_index :conversations, :archived_at
  end
end
