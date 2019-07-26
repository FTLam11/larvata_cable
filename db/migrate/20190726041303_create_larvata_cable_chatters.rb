class CreateLarvataCableChatters < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_chatters do |t|
      t.references :user, null: false, foreign_key: { to_table: LarvataCable.user_class.table_name.to_sym }
      t.references :larvata_cable_chat_room, foreign_key: true, null: false
      t.datetime :last_read_at

      t.timestamps
    end
  end
end
