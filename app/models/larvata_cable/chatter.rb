module LarvataCable
  class Chatter < ApplicationRecord
    belongs_to :user, foreign_key: 'larvata_cable_user_id'
    belongs_to :chat_room, foreign_key: 'larvata_cable_chat_room_id'

    validates :larvata_cable_user_id,
      uniqueness: { scope: :larvata_cable_chat_room_id,
                    message: 'should not have duplicate members',
                    case_sensitive: false }

    def as_json(*)
      super(only: [:created_at, :updated_at]).tap do |hash|
        hash[:user_id] = larvata_cable_user_id
      end
    end
  end
end
