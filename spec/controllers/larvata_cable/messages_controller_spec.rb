require 'rails_helper'

module LarvataCable
  RSpec.describe MessagesController, type: :request do
    describe 'GET #index' do
      it 'fetches messages for a given chat room ID' do
        user = create(:user)
        chat_room = create(:chat_room, owner: user, tenant: user.tenant)
        message = create(:message, chat_room: chat_room, sender: user, body: 'FALCON PAWNCH')
        params = { app_id: chat_room.tenant.id, data: { user_id: 1, chat_room_id: chat_room.id } }
        payload = LarvataCable::AuthWrapper.generate_token(params)

        get chat_room_messages_path(chat_room), params: payload, as: :json

        expect(response).to have_http_status(200)
        expect(body_content['messages']).to include(JSON.parse(message.to_json))
      end
    end
  end
end
