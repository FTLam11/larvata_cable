module LarvataCable
  class Message < ApplicationRecord
    belongs_to :sender, class_name: 'LarvataCable::User'
    belongs_to :chat_room, foreign_key: 'larvata_cable_chat_room_id'

    validates_presence_of :body

    def as_json(*)
      super(only: [:id, :body, :created_at]).tap do |hash|
        hash[:sender_id] = sender.host_user_id
      end
    end
  end
end
