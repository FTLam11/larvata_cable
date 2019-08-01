module LarvataCable
  class ChatRoom < ApplicationRecord
    belongs_to :owner, class_name: LarvataCable.user_class.to_s
    has_many :chatters, foreign_key: 'larvata_cable_chat_room_id'
    has_many :members, through: :chatters, source: LarvataCable.user_class.to_s.downcase
    has_many :messages, -> { order(:created_at) }, foreign_key: 'larvata_cable_chat_room_id'
  end
end
