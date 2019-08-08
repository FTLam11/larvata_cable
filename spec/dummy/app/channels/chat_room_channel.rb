class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # TODO what is chat room creation/joining strategy?
    # Create seperate channels for different websocket use cases
    # Stream all rooms of a given channel upon upgrading websocket connection?
    # AppearanceChannel
    # AnnouncementChannel
    if @chat_room = find_chat_room
      stream_for @chat_room
    else
      reject
    end
  end

  def unsubscribed
    stop_all_streams
  end

  def chat(data)
    # TODO use identifier instead of model to avoid DB query
    self.class.broadcast_to(LarvataCable::ChatRoom.find(data['chat_room_id']),
                            text: data['body'])
  end

  private

  def find_chat_room
    @chat_room = current_user.chat_rooms.where(id: params[:chat_room_id]).first
  end
end
