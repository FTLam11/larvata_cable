class AddForeignKeysToUsersAndChatRooms < ActiveRecord::Migration[5.1]
  def change
    add_foreign_key :larvata_cable_chatters, :users
    add_foreign_key :larvata_cable_chatters, :larvata_cable_chat_rooms
  end
end
