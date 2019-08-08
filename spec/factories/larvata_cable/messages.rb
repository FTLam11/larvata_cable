FactoryBot.define do
  factory :larvata_cable_message, class: LarvataCable::Message, aliases: [:message] do
    sender { nil }
    chat_room { nil }
    body { "Yo" }
  end
end
