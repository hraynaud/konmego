class CreateMessageReads < ActiveRecord::Migration[7.1]
  def change
    create_table :message_reads do |t|
      t.references :message, null: false, foreign_key: true
      t.string :reader_neo4j_id, null: false
      t.datetime :read_at, null: false

      t.timestamps
    end

    add_index :message_reads, [:message_id, :reader_neo4j_id],
              unique: true, name: 'unique_message_read'
    add_index :message_reads, :reader_neo4j_id
  end
end
