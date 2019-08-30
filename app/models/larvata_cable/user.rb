module LarvataCable
  class User < ApplicationRecord
    belongs_to :tenant
    has_many :chatters, class_name: 'LarvataCable::Chatter', foreign_key: 'larvata_cable_user_id'
    has_many :chat_rooms, through: :chatters, class_name: 'LarvataCable::ChatRoom', foreign_key: 'larvata_cable_chat_room_id'

    validates_presence_of :host_user_id
  end
end
