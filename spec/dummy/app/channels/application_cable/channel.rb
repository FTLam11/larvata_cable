module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      if @chat_room = find_chat_room
        stream_for @chat_room
      else
        reject
      end
    end

    private

    def find_chat_room
      @chat_room = current_user.chat_rooms.where(id: params[:chat_room_id]).first
    end
  end
end
