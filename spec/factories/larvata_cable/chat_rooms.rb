FactoryBot.define do
  factory :larvata_cable_chat_room, class: LarvataCable::ChatRoom, aliases: [:chat_room] do
    name { "TONGZHI" }
    association :owner, factory: :user
  end
end
