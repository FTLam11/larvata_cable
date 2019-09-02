module LarvataCable
  class MessagesController < ApplicationController
    def index
      # TODO verify user is a member of requested chat room?

      auth_service = LarvataCable::AuthorizeHost.new(params)

      if auth_service.success
        messages = LarvataCable::ChatRoom.find(auth_service.data['chat_room_id']).messages.limit(10)

        render json: { messages: messages }
      else
        render json: { error: auth_service.error }, status: 400 and return
      end
    end
  end
end
