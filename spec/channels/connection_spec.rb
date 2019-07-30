require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do
  context 'with a valid authorization header' do
    it 'successfully connects' do
      user = instance_double(User, id: 322)
      token = JWT.encode({ user_id: user.id }, Rails.application.secrets[:secret_key_base], 'HS256')
      allow(LarvataCable.user_class).to receive(:find).with(user.id).and_return(user)

      connect '/cable', headers: { 'Authorization' => "Bearer #{token}" }

      expect(connection.current_user).to be user
    end
  end

  context 'with no authorization header' do
    it 'rejects connection' do
      expect { connect '/cable' }.to have_rejected_connection
    end
  end
end
