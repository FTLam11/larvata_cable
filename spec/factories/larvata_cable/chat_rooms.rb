FactoryBot.define do
  sequence(:chat_name) { |n| "chat#{n}" }

  factory :larvata_cable_chat_room, class: LarvataCable::ChatRoom, aliases: [:chat_room] do
    name { generate(:chat_name) }
    association :owner, factory: :user
    association :tenant
  end
end
