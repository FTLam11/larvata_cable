module LarvataCable
  class Chatter < ApplicationRecord
    belongs_to :user
    belongs_to :chat_room, foreign_key: 'larvata_cable_chat_room_id'
  end
end
