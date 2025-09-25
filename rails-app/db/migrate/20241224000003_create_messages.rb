class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.references :conversation, null: false, foreign_key: true
      t.string :sender_neo4j_id
      t.text :content
      t.string :message_type, default: 'text'
      t.references :reply_to, foreign_key: { to_table: :messages }, null: true
      t.datetime :edited_at
      t.datetime :deleted_at
      t.jsonb :metadata, default: {}

      t.timestamps
    end

    add_index :messages, :sender_neo4j_id
    add_index :messages, :created_at
    add_index :messages, :deleted_at
  end
end
