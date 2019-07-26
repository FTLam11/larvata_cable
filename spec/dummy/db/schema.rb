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

ActiveRecord::Schema.define(version: 20190726041303) do

  create_table "larvata_cable_chat_rooms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "name"
    t.bigint "owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_larvata_cable_chat_rooms_on_owner_id"
  end

  create_table "larvata_cable_chatters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.bigint "user_id", null: false
    t.bigint "larvata_cable_chat_room_id", null: false
    t.datetime "last_read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["larvata_cable_chat_room_id"], name: "index_larvata_cable_chatters_on_larvata_cable_chat_room_id"
    t.index ["user_id"], name: "index_larvata_cable_chatters_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci" do |t|
    t.string "account", null: false
    t.string "auth_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account"], name: "index_users_on_account", unique: true
  end

  add_foreign_key "larvata_cable_chat_rooms", "users", column: "owner_id"
  add_foreign_key "larvata_cable_chatters", "larvata_cable_chat_rooms"
  add_foreign_key "larvata_cable_chatters", "users"
end
