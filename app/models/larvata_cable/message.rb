module LarvataCable
  class Message < ApplicationRecord
    belongs_to :sender, class_name: LarvataCable.user_class
    belongs_to :chat_room, foreign_key: 'larvata_cable_chat_room_id'
  end
end
