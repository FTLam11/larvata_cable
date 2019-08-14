FactoryBot.define do
  factory :user do
    account { "larvata_acct" }
    auth_token { nil }
    password { '12345678' }
  end
end
