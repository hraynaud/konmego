class RenameNeo4jColumnsInChatTables < ActiveRecord::Migration[7.1]
  def change
    # Rename columns in conversations table
    rename_column :conversations, :context_neo4j_id, :context_id

    # Rename columns in conversation_participants table
    rename_column :conversation_participants, :person_neo4j_id, :person_id

    # Rename columns in messages table
    rename_column :messages, :sender_neo4j_id, :sender_id

    # Rename columns in message_reads table
    rename_column :message_reads, :reader_neo4j_id, :reader_id

    # Only update the composite/named indexes that need manual handling
    # Rails will automatically update simple single-column indexes

    # Update conversation_participants composite index
    if index_exists?(:conversation_participants, %i[conversation_id person_neo4j_id],
                     name: 'unique_conversation_participant')
      remove_index :conversation_participants, name: 'unique_conversation_participant'
      add_index :conversation_participants, %i[conversation_id person_id],
                unique: true, name: 'unique_conversation_participant'
    end

    # Update conversations composite index
    if index_exists?(:conversations, %i[context_type context_neo4j_id])
      remove_index :conversations, %i[context_type context_neo4j_id]
      add_index :conversations, %i[context_type context_id]
    end

    # Update message_reads composite index
    return unless index_exists?(:message_reads, %i[message_id reader_neo4j_id], name: 'unique_message_read')

    remove_index :message_reads, name: 'unique_message_read'
    add_index :message_reads, %i[message_id reader_id],
              unique: true, name: 'unique_message_read'
  end
end
