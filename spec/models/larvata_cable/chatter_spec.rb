require 'rails_helper'

module LarvataCable
  RSpec.describe Chatter, type: :model do
    describe 'validations' do
      it { should belong_to(:user) }
      it { should belong_to(:chat_room) }
    end
  end
end
