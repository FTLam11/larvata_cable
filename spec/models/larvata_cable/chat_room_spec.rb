require 'rails_helper'

module LarvataCable
  RSpec.describe ChatRoom, type: :model do
    describe 'associations' do
      it { should belong_to(:owner) }
      it { should have_many(:chatters).with_foreign_key('larvata_cable_chat_room_id') }
      it { should have_many(:members).through(:chatters).source('user') }
      it { should have_many(:messages).order(:created_at).with_foreign_key('larvata_cable_chat_room_id') }
    end

    it 'may have a name' do
      named_room = build(:chat_room, name: 'TONGZHI')
      anonymous_room = build(:chat_room, name: nil)

      expect(named_room).to be_valid
      expect(anonymous_room).to be_valid
    end
  end
end
