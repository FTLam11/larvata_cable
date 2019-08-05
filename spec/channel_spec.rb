require 'rails_helper'

RSpec.describe ApplicationCable::Channel, type: :channel do
  context 'with no chat room id' do
    it 'rejects the connection' do
      user = instance_double(User, id: 322)
      stub_connection current_user: user
      stub_connection set_chat_room: nil

      subscribe

      expect(subscription).to be_rejected
    end
  end
end
