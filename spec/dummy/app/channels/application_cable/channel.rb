module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      @chat_room = set_chat_room
      reject unless @chat_room
    end

    private

    def set_chat_room
      current_user.chat_rooms.where(id: params[:chat_room_id]).first
    end
  end
end
