require 'rails_helper'

module LarvataCable
  RSpec.describe User, type: :model do
    describe 'associations' do
      it { should belong_to(:tenant) }
      it { should have_many(:chatters).class_name('LarvataCable::Chatter') }
      it { should have_many(:chat_rooms).through(:chatters).class_name('LarvataCable::ChatRoom') }
    end

    describe 'validations' do
      it { should validate_presence_of(:host_user_id) }
    end
  end
end
