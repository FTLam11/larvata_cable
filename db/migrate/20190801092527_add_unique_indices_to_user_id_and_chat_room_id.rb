class AddUniqueIndicesToUserIdAndChatRoomId < ActiveRecord::Migration[5.1]
  def change
    add_index :larvata_cable_chatters, [:user_id, :larvata_cable_chat_room_id], unique: true, name: 'index_larvata_cable_chatters_on_user_id_and_chat_room_id'
  end
end
