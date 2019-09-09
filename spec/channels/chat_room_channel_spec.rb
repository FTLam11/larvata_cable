require 'rails_helper'

RSpec.describe ChatRoomChannel, type: :channel do
  include ActiveJob::TestHelper

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

        subscribe(chat_room_id: 322)

        expect(subscription).to be_confirmed
        expect(subscription).to have_stream_for("chat_room:chat_room_#{chat_room.id}")
      end
    end
  end

  describe '#unsubscribed' do
    it "unsubscribes from all the channel's streams" do
      chat_room = instance_double(LarvataCable::ChatRoom, id: 322)
      stub_connection find_chat_room: chat_room

      subscribe(chat_room_id: 322)
      unsubscribe

      expect(subscription).to_not have_streams
    end
  end

  describe '#chat' do
    it 'broadcasts a message to a stream' do
      chat_room = create(:chat_room, name: 'MELEE')
      falcon = chat_room.members.first
      stub_connection current_user: falcon

      data = { body: 'FALCON PAWNCH', chat_room_id: chat_room.id }
      subscribe(chat_room_id: chat_room.id)

      Sidekiq::Testing.inline! do
        expect { perform_enqueued_jobs { perform(:chat, data) } }.to have_broadcasted_to("chat_room:chat_room_#{chat_room.id}")
          .from_channel(ChatRoomChannel).with(data.merge(sender: falcon.host_user_id))
      end
    end
  end
end
