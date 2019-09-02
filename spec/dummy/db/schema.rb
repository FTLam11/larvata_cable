# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190801092527) do

  create_table "larvata_cable_chat_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name"
    t.bigint "owner_id", null: false
    t.string "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_larvata_cable_chat_rooms_on_owner_id"
    t.index ["tenant_id"], name: "index_larvata_cable_chat_rooms_on_tenant_id"
  end

  create_table "larvata_cable_chatters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "larvata_cable_user_id", null: false
    t.bigint "larvata_cable_chat_room_id", null: false
    t.datetime "last_read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["larvata_cable_chat_room_id"], name: "index_larvata_cable_chatters_on_larvata_cable_chat_room_id"
    t.index ["larvata_cable_user_id", "larvata_cable_chat_room_id"], name: "index_larvata_cable_chatters_on_user_id_and_chat_room_id", unique: true
    t.index ["larvata_cable_user_id"], name: "index_larvata_cable_chatters_on_larvata_cable_user_id"
  end

  create_table "larvata_cable_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "sender_id", null: false
    t.bigint "larvata_cable_chat_room_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["larvata_cable_chat_room_id"], name: "index_larvata_cable_messages_on_larvata_cable_chat_room_id"
    t.index ["sender_id"], name: "index_larvata_cable_messages_on_sender_id"
  end

  create_table "larvata_cable_tenants", primary_key: "application_id", id: :string, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_larvata_cable_tenants_on_application_id", unique: true
  end

  create_table "larvata_cable_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "host_user_id", null: false
    t.string "tenant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["host_user_id"], name: "index_larvata_cable_users_on_host_user_id"
    t.index ["tenant_id"], name: "index_larvata_cable_users_on_tenant_id"
  end

  add_foreign_key "larvata_cable_chat_rooms", "larvata_cable_tenants", column: "tenant_id", primary_key: "application_id"
  add_foreign_key "larvata_cable_chat_rooms", "larvata_cable_users", column: "owner_id"
  add_foreign_key "larvata_cable_chatters", "larvata_cable_chat_rooms"
  add_foreign_key "larvata_cable_chatters", "larvata_cable_users"
  add_foreign_key "larvata_cable_messages", "larvata_cable_chat_rooms"
  add_foreign_key "larvata_cable_messages", "larvata_cable_users", column: "sender_id"
  add_foreign_key "larvata_cable_users", "larvata_cable_tenants", column: "tenant_id", primary_key: "application_id"
end
