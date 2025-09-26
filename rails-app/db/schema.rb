# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_09_25_000005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conversation_participants", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.string "person_id", null: false
    t.string "role", default: "member"
    t.datetime "joined_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "left_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id", "person_id"], name: "unique_conversation_participant", unique: true
    t.index ["conversation_id"], name: "index_conversation_participants_on_conversation_id"
    t.index ["person_id"], name: "index_conversation_participants_on_person_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.string "title"
    t.string "conversation_type", null: false
    t.string "context_type"
    t.string "context_id"
    t.datetime "last_message_at"
    t.datetime "archived_at"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["archived_at"], name: "index_conversations_on_archived_at"
    t.index ["context_type", "context_id"], name: "index_conversations_on_context_type_and_context_id"
    t.index ["conversation_type"], name: "index_conversations_on_conversation_type"
    t.index ["last_message_at"], name: "index_conversations_on_last_message_at"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at", precision: nil
    t.datetime "locked_at", precision: nil
    t.datetime "failed_at", precision: nil
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "message_reads", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.string "reader_id", null: false
    t.datetime "read_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["message_id", "reader_id"], name: "unique_message_read", unique: true
    t.index ["message_id"], name: "index_message_reads_on_message_id"
    t.index ["reader_id"], name: "index_message_reads_on_reader_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.string "sender_id"
    t.text "content"
    t.string "message_type", default: "text"
    t.bigint "reply_to_id"
    t.datetime "edited_at"
    t.datetime "deleted_at"
    t.jsonb "metadata", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["created_at"], name: "index_messages_on_created_at"
    t.index ["deleted_at"], name: "index_messages_on_deleted_at"
    t.index ["reply_to_id"], name: "index_messages_on_reply_to_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  add_foreign_key "conversation_participants", "conversations"
  add_foreign_key "message_reads", "messages"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "messages", column: "reply_to_id"
end
