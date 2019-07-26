class CreateLarvataCableChatRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_chat_rooms do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: { to_table: LarvataCable.owner_class.table_name.to_sym }

      t.timestamps
    end

  end
end
