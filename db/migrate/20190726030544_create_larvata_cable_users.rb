class CreateLarvataCableUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :larvata_cable_users do |t|
      t.bigint :host_user_id, null: false
      t.string :tenant_id, null: false

      t.timestamps

      t.index :host_user_id
      t.index :tenant_id
    end

    add_foreign_key :larvata_cable_users, :larvata_cable_tenants, column: :tenant_id, primary_key: 'application_id'
  end
end
