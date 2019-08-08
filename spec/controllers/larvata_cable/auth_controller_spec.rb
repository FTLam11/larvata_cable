require 'rails_helper'

module LarvataCable
  RSpec.describe(AuthController, type: :request) do
    let(:expires_in) { 60 * 60 }

    describe 'POST #create' do
      it 'responds with a signed JWT' do
        user = create(:user, account: 'Falcon')
        params = { account: 'Falcon', password: '12345678' }

        post login_path, params: params, as: :json

        expect(response).to have_http_status(200)
        expect(body_content).to eq('access_token' => user.auth_token,
                                   'token_type' => 'bearer',
                                   'expires_in' => expires_in)
      end
    end

    describe 'DELETE #destroy' do
      xit 'revokes the JWT' do
        user = create(:user, account: 'Falcon')
        headers = { Authorization: "Bearer #{user.auth_token}" }

        delete logout_path, headers: headers

        expect(response).to(have_http_status(204))
        # TODO add expectation about invalid auth_token
        # need to implement token expiration
      end
    end
  end
end