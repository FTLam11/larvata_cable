class CreateLarvataCableChatters < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_chatters do |t|
      t.references :larvata_cable_user, null: false, foreign_key: true
      t.references :larvata_cable_chat_room, null: false, foreign_key: true
      t.datetime :last_read_at

      t.timestamps
    end
  end
end
