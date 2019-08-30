module LarvataCable
  class Chatter < ApplicationRecord
    belongs_to :user, foreign_key: 'larvata_cable_user_id'
    belongs_to :chat_room, foreign_key: 'larvata_cable_chat_room_id'

    validates :larvata_cable_user_id, uniqueness: { scope: :larvata_cable_chat_room_id, message: 'should not have duplicate members' }
  end
end
