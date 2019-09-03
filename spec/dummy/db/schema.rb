# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_01_092527) do

  create_table "larvata_cable_chat_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "tenant_id", null: false
    t.bigint "owner_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_larvata_cable_chat_rooms_on_owner_id"
    t.index ["tenant_id"], name: "index_larvata_cable_chat_rooms_on_tenant_id"
  end

  create_table "larvata_cable_chatters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "larvata_cable_user_id", null: false
    t.bigint "larvata_cable_chat_room_id", null: false
    t.datetime "last_read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["larvata_cable_chat_room_id"], name: "index_larvata_cable_chatters_on_larvata_cable_chat_room_id"
    t.index ["larvata_cable_user_id", "larvata_cable_chat_room_id"], name: "index_larvata_cable_chatters_on_user_id_and_chat_room_id", unique: true
    t.index ["larvata_cable_user_id"], name: "index_larvata_cable_chatters_on_larvata_cable_user_id"
  end

  create_table "larvata_cable_messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.bigint "sender_id", null: false
    t.bigint "larvata_cable_chat_room_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["larvata_cable_chat_room_id"], name: "index_larvata_cable_messages_on_larvata_cable_chat_room_id"
    t.index ["sender_id"], name: "index_larvata_cable_messages_on_sender_id"
  end

  create_table "larvata_cable_tenants", primary_key: "application_id", id: :string, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_larvata_cable_tenants_on_application_id", unique: true
  end

  create_table "larvata_cable_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "tenant_id", null: false
    t.bigint "host_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tenant_id", "host_user_id"], name: "index_larvata_cable_users_on_tenant_id_and_host_user_id", unique: true
  end

  add_foreign_key "larvata_cable_chat_rooms", "larvata_cable_tenants", column: "tenant_id", primary_key: "application_id"
  add_foreign_key "larvata_cable_chat_rooms", "larvata_cable_users", column: "owner_id"
  add_foreign_key "larvata_cable_chatters", "larvata_cable_chat_rooms"
  add_foreign_key "larvata_cable_chatters", "larvata_cable_users"
  add_foreign_key "larvata_cable_messages", "larvata_cable_chat_rooms"
  add_foreign_key "larvata_cable_messages", "larvata_cable_users", column: "sender_id"
  add_foreign_key "larvata_cable_users", "larvata_cable_tenants", column: "tenant_id", primary_key: "application_id"
end
