require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do
  context 'with a valid authorization header' do
    it 'successfully connects' do
      user = create(:user)
      token = LarvataCable::JwtWrapper.generate_token(user)

      connect '/cable', headers: { 'Authorization' => "Bearer #{token}" }

      expect(connection.current_user).to eq user
    end
  end

  context 'with no authorization header' do
    it 'rejects connection' do
      expect { connect '/cable' }.to have_rejected_connection
    end
  end
end
