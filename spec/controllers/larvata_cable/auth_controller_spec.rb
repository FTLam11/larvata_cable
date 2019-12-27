require 'rails_helper'

module LarvataCable
  RSpec.describe AuthController, type: :request do
    describe 'POST #create' do
      context 'with valid credentials' do
        it 'responds with a signed JWT' do
          tenant = create(:tenant)
          params = { app_id: tenant.id, data: { user_id: 1 } }
          payload = AuthWrapper.generate_token(params)

          post auth_path, params: payload, as: :json
          token = Access.generate_token(User.last)

          expect(response).to have_http_status(200)
          expect(body_content).to eq('token' => token)
        end
      end

      context 'with invalid credentials' do
        it 'responds with a 400' do
          params = { app_id: 'fake', data: 'ASDFSASDJL' }

          post auth_path, params: params, as: :json

          expect(response).to have_http_status(400)
        end
      end
    end
  end
end
