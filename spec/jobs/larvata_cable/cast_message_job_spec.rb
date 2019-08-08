require 'rails_helper'

module LarvataCable
  RSpec.describe CastMessageJob do
    ActiveJob::Base.queue_adapter = :test

    it 'enqueues a job with appropriate arguments' do
      falcon = create(:user)
      chat_room = create(:chat_room, owner: falcon)
      message = create(:message, sender: falcon, chat_room: chat_room, body: 'YES')

      expect { CastMessageJob.perform_later(message) }.to have_enqueued_job.with(message)
    end
  end
end
