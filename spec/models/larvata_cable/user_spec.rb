require 'rails_helper'

module LarvataCable
  RSpec.describe User, type: :model do
    describe 'associations' do
      it { should have_many(:chatters).class_name('LarvataCable::Chatter') }
      it { should have_many(:chat_rooms).through(:chatters).class_name('LarvataCable::ChatRoom') }
    end
  end
end
