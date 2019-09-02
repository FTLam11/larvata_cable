class CreateLarvataCableTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_tenants, id: false do |t|
      t.string :application_id, primary_key: true, null: false
      t.string :name, unique: true, null: false

      t.timestamps

      t.index :application_id, unique: true
    end
  end
end
