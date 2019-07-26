FactoryBot.define do
  factory :larvata_cable_message, class: LarvataCable::Message, aliases: [:message] do
    user { nil }
    chat_room { nil }
    body { "Yo" }
  end
end
