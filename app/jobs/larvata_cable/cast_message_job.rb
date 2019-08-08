module LarvataCable
  class CastMessageJob < ApplicationJob
    queue_as :default

    def perform(message)
      ActionCable.server.broadcast("chat_room_#{message.larvata_cable_chat_room_id}", {
        sender: message.sender.send(LarvataCable.user_account_column),
        body: message.body,
        chat_room_id: message.larvata_cable_chat_room_id
      })
    end
  end
end
