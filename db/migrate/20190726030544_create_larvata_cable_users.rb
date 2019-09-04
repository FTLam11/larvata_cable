class CreateLarvataCableUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_users do |t|
      t.string :tenant_id, null: false
      t.bigint :host_user_id, null: false

      t.timestamps
    end

    add_foreign_key :larvata_cable_users, :larvata_cable_tenants, column: :tenant_id, primary_key: 'application_id'
    add_index :larvata_cable_users, [:tenant_id, :host_user_id], unique: true, name: 'index_larvata_cable_users_on_tenant_id_and_host_user_id'
  end
end
