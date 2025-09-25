class CreateConversationParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :conversation_participants do |t|
      t.references :conversation, null: false, foreign_key: true
      t.string :person_neo4j_id, null: false
      t.string :role, default: 'member'
      t.datetime :joined_at, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :left_at

      t.timestamps
    end

    add_index :conversation_participants, [:conversation_id, :person_neo4j_id],
              unique: true, name: 'unique_conversation_participant'
    add_index :conversation_participants, :person_neo4j_id
  end
end
