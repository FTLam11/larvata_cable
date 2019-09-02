require 'rails_helper'

module LarvataCable
  RSpec.describe Message, type: :model do
    describe 'associations' do
      it { should belong_to(:sender).class_name('LarvataCable::User') }
      it { should belong_to(:chat_room) }
    end

    describe 'validations' do
      it { should validate_presence_of(:body) }
    end
  end
end
