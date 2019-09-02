class CreateLarvataCableMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: :larvata_cable_users }
      t.references :larvata_cable_chat_room, null: false, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
