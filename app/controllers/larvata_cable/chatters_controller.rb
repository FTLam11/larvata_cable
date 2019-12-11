module LarvataCable
  class ChattersController < ApplicationController
    def create
      auth_service = AuthorizeHost.new(params)

      if auth_service.success
        chatter = Chatter.new(larvata_cable_chat_room_id: params[:chat_room_id],
                                            user: auth_service.user)

        if chatter.save
          render json: {}, status: 201
        else
          render json: { error: chatter.errors.full_messages }, status: 400
        end
      else
        render json: { error: auth_service.error }, status: 400
      end
    end

    def index
      auth_service = AuthorizeHost.new(params)

      if auth_service.success
        chat_room = ChatRoom.find(params[:chat_room_id])
        render json: { members: chat_room.chatters }
      else
        render json: { error: auth_service.error }, status: 400
      end
    end

    def destroy
      auth_service = AuthorizeHost.new(params)

      if auth_service.success
        user = User.where(tenant: auth_service.tenant, host_user_id: params[:id]).first
        member = Chatter.where(larvata_cable_chat_room_id: params[:chat_room_id],
                                             user: user).first
        if member.destroy
          render json: {}, status: 204
        else
          render json: { error: member.errors.full_messages }, status: 400
        end
      else
        render json: { error: auth_service.error }, status: 400
      end
    end
  end
end
