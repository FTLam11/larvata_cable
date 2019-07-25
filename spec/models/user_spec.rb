require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has an account' do
    user = create(:user, account: 'Falcon')

    expect(user.account).to eq 'Falcon'
  end
end
