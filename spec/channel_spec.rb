require 'rails_helper'

RSpec.describe ChatRoomChannel, type: :channel do
  describe '#subscribed' do
    context 'with no chat room id' do
      it 'rejects the subscription' do
        stub_connection find_chat_room: nil

        subscribe

        expect(subscription).to be_rejected
      end
    end

    context 'with a chat room id' do
      it 'subscribes to a chat room stream' do
        chat_room = instance_double(LarvataCable::ChatRoom, id: 322)
        stub_connection find_chat_room: chat_room

        subscribe(room_id: 322)

        expect(subscription).to be_confirmed
        expect(subscription).to have_stream_for(chat_room)
      end
    end
  end

  describe '#unsubscribed' do
    context 'with no chat room id' do
      xit 'ignores the request' do

      end
    end
  end
end
