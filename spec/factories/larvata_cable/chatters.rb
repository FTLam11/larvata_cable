FactoryBot.define do
  factory :larvata_cable_chatter, class: 'LarvataCable::Chatter', aliases: [:chatter] do
    user { nil }
    chat_room { nil }
    last_read_at { "2019-07-26 12:13:03" }
  end
end
