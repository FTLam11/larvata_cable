require 'rails_helper'

RSpec.describe ApplicationCable::Channel, type: :channel do
  context 'with no chat room id' do
    it 'rejects the subscription' do
      stub_connection set_chat_room: nil

      subscribe

      expect(subscription).to be_rejected
    end
  end
end
