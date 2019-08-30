module LarvataCable
  class ChatRoom < ApplicationRecord
    belongs_to :owner, class_name: 'LarvataCable::User'
    belongs_to :tenant, class_name: 'LarvataCable::Tenant'
    has_many :chatters, foreign_key: 'larvata_cable_chat_room_id'
    has_many :members, through: :chatters, source: 'user'
    has_many :messages, -> { order(:created_at) }, foreign_key: 'larvata_cable_chat_room_id'
  end
end
