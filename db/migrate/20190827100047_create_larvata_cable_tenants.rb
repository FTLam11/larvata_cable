class CreateLarvataCableTenants < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_tenants do |t|
      t.string :application_id, unique: true, null: false
      t.string :name, unique: true, null: false

      t.timestamps
    end

    add_index(:larvata_cable_tenants, :application_id)
  end
end
