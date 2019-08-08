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
    # TODO what if this channel has many rooms
    message = @chat_room.messages.create(sender: current_user, body: data['body'])
    LarvataCable::CastMessageJob.perform_later(message)
  end

  private

  def find_chat_room
    @chat_room = current_user.chat_rooms.where(id: params[:chat_room_id]).first
  end
end
