module LarvataCable
  class CastMessageWorker
    include Sidekiq::Worker

    def perform(message_id)
      message = LarvataCable::Message.find(message_id)
      chat_room_id = message.larvata_cable_chat_room_id

      ActionCable.server.broadcast("chat_room_#{chat_room_id}", {
        sender: message.sender.send(LarvataCable.user_account_column),
        body: message.body,
        chat_room_id: chat_room_id
      })
    end
  end
end
