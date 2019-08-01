require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a unique account' do
    user = create(:user, account: 'Falcon')
    duplicate_user = build(:user, account: 'Falcon')

    expect(user.account).to eq 'Falcon'
    expect(duplicate_user).to be_invalid
  end

  it 'has a signed JWT containing the user id' do
    user = create(:user, account: 'Falcon')

    payload = LarvataCable::JWTWrapper.decode(user.auth_token)

    expect(payload['user_id']).to eq user.id
  end
end
