require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a unique account' do
    user = create(:user, account: 'Falcon')
    duplicate_user = build(:user, account: 'Falcon')

    expect(user.account).to eq 'Falcon'
    expect(duplicate_user).to be_invalid
  end
end
