require 'rails_helper'

module LarvataCable
  RSpec.describe ChattersController, type: :request do
    describe 'POST #create' do
      it 'creates a chat room for the tenant' do
        user = create(:user)
        chat_room = create(:chat_room)
        params = { app_id: user.tenant.id, data: { user_id: 1 } }
        payload = AuthWrapper.generate_token(params)

        post chat_room_members_path(chat_room), params: payload, as: :json

        expect(response).to have_http_status(201)
      end
    end

    describe 'GET #index' do
      it 'fetches all members for a requested chat room' do
        user = create(:user)
        chat_room = create(:chat_room, owner: user, tenant: user.tenant)
        params = { app_id: chat_room.tenant.id, data: { user_id: 1 } }
        payload = AuthWrapper.generate_token(params)

        get chat_room_members_path(chat_room), params: payload, as: :json

        expect(response).to have_http_status(200)
        expect(body_content['members']).to include(JSON.parse(chat_room.chatters.first.to_json))
      end
    end

    describe 'DELETE #destroy' do
      it 'removes a member from a chat room' do
        user = create(:user)
        chat_room = create(:chat_room, owner: user, tenant: user.tenant)
        params = { app_id: chat_room.tenant.id, data: { user_id: 1 } }
        payload = AuthWrapper.generate_token(params)

        delete chat_room_member_path(chat_room, params[:data][:user_id]), params: payload, as: :json

        expect(response).to have_http_status(204)
        expect(chat_room.reload.members).to_not include(user)
      end
    end
  end
end
