class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :account, null: false, default: ''
      t.string :auth_token

      t.timestamps
    end

    add_index :users, :account, unique: true
  end
end
