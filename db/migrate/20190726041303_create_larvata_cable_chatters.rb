class CreateLarvataCableChatters < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_chatters do |t|
      t.bigint :user_id, null: false
      t.bigint :larvata_cable_chat_room_id, null: false
      t.datetime :last_read_at

      t.timestamps
    end
  end
end
