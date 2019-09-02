require 'rails_helper'

module LarvataCable
  RSpec.describe ChatRoomsController, type: :request do
    describe 'POST #create' do
      context 'with valid credentials' do
        it 'creates a chat room for the tenant' do
          tenant = create(:tenant)
          params = { app_id: tenant.id, data: { user_id: 1, chat_room_name: 'MELEE # 1' } }
          payload = LarvataCable::AuthWrapper.generate_token(params)

          post chat_rooms_path, params: payload, as: :json

          expect(response).to have_http_status(201)
          expect(body_content['name']).to eq(params[:data][:chat_room_name])
          expect(body_content['owner_id']).to eq(params[:data][:user_id])
          expect(body_content['app_id']).to eq(params[:app_id])
        end
      end

      context 'with invalid credentials' do
        it 'responds with a 400' do
          params = { app_id: 'fake', data: 'ASDFSASDJL' }

          post chat_rooms_path, params: params, as: :json

          expect(response).to have_http_status(400)
        end
      end
    end
  end
end
