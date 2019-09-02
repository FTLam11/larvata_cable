module LarvataCable
  class ChatRoomsController < ApplicationController
    def create
      auth_service = LarvataCable::AuthorizeHost.new(params)

      if auth_service.success
        chat_room = LarvataCable::ChatRoom.new(
          owner: auth_service.user,
          tenant: auth_service.tenant,
          name: auth_service.data['chat_room_name']
        )

        if chat_room.save
          render json: chat_room, status: 201
        else
          render json: { error: chat_room.errors.full_messages }, status: 400 and return
        end
      else
        render json: { error: auth_service.error }, status: 400 and return
      end
    end
  end
end
