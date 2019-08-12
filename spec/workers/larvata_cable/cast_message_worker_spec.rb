require 'rails_helper'

module LarvataCable
  RSpec.describe CastMessageWorker, type: :worker do
    it 'enqueues a job with appropriate arguments' do
      falcon = create(:user)
      chat_room = create(:chat_room, owner: falcon)
      message = create(:message, sender: falcon, chat_room: chat_room, body: 'YES')

      expect do
        CastMessageWorker.perform_async(message.id)
      end.to change(CastMessageWorker.jobs, :size).by(1)
    end
  end
end
