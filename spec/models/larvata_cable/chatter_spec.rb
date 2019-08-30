require 'rails_helper'

module LarvataCable
  RSpec.describe Chatter, type: :model do
    describe 'associations' do
      it { should belong_to(:user) }
      it { should belong_to(:chat_room) }
    end

    describe 'validations' do
      let(:chat_room) { create(:chat_room) }
      subject { create(:chatter, user: chat_room.owner, chat_room: chat_room) }

      it do
        should validate_uniqueness_of(:larvata_cable_user_id)
          .scoped_to(:larvata_cable_chat_room_id)
          .with_message("should not have duplicate members")
      end
    end
  end
end
