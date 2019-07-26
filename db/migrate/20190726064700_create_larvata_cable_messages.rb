class CreateLarvataCableMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_messages do |t|
      t.references :sender, null: false, foreign_key: { to_table: LarvataCable.user_class.table_name.to_sym }
      t.references :larvata_cable_chat_room, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
