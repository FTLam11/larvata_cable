require 'rails_helper'

module LarvataCable
  RSpec.describe ChatRoom, type: :model do
    describe 'associations' do
      it { should belong_to(:owner) }
      it { should have_many(:chatters).class_name('LarvataCable::Chatter') }
      it { should have_many(:members).through(:chatters).source(LarvataCable.user_class.to_s.downcase) }
    end

    it 'may have a name' do
      owner = create(:user)
      named_room = build(:chat_room, name: 'TONGZHI', owner: owner)
      anonymous_room = build(:chat_room, name: nil, owner: owner)

      expect(named_room).to be_valid
      expect(anonymous_room).to be_valid
    end
  end
end
