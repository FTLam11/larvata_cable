require 'rails_helper'

module LarvataCable
  RSpec.describe Message, type: :model do
    describe 'associations' do
      it { should belong_to(:sender).class_name(LarvataCable.user_class.to_s) }
      it { should belong_to(:chat_room) }
    end
  end
end
