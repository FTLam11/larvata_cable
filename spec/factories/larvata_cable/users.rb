FactoryBot.define do
  factory :larvata_cable_user, class: 'LarvataCable::User', aliases: [:user] do
    host_user_id { 1 }
    association :tenant
  end
end
