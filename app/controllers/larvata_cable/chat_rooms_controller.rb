module LarvataCable
  class ChatRoomsController < ApplicationController
    def create
      auth_service = AuthorizeHost.new(params)

      if auth_service.success
        chat_room = ChatRoom.new(
          owner: auth_service.user,
          tenant: auth_service.tenant,
          name: auth_service.data['chat_room_name']
        )

        if chat_room.save
          render json: chat_room, status: 201
        else
          render json: { error: chat_room.errors.full_messages }, status: 400
        end
      else
        render json: { error: auth_service.error }, status: 400
      end
    end

    def index
      auth_service = AuthorizeHost.new(params)

      if auth_service.success
        render json: { chat_rooms: auth_service.user.chat_rooms }
      else
        render json: { error: auth_service.error }, status: 400
      end
    end
  end
end
