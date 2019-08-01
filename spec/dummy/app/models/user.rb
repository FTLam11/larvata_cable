class User < ApplicationRecord
  has_many :chatters, class_name: 'LarvataCable::Chatter'
  has_many :chat_rooms, through: :chatters, class_name: 'LarvataCable::ChatRoom', foreign_key: 'larvata_cable_chat_room_id'

  validates_presence_of :account
  validates_uniqueness_of :account
end
