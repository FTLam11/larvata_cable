class CreateLarvataCableChatRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_chat_rooms do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: { to_table: :larvata_cable_users }
      t.string :tenant_id, null: false

      t.timestamps

      t.index :tenant_id
    end

    add_foreign_key :larvata_cable_chat_rooms, :larvata_cable_tenants, column: :tenant_id, primary_key: 'application_id'
  end
end
