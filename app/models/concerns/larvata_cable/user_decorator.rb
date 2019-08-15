module LarvataCable
  module UserDecorator
    extend ActiveSupport::Concern

    included do
      has_many :chatters, class_name: 'LarvataCable::Chatter'
      has_many :chat_rooms, through: :chatters, class_name: 'LarvataCable::ChatRoom', foreign_key: 'larvata_cable_chat_room_id'

      after_create :generate_token

      def generate_token
        expires_at = Time.zone.now.to_i + LarvataCable.exp_claim_time

        update(LarvataCable.auth_token_column => LarvataCable::JWTWrapper.encode(
          { user_id: id, updated_at: Time.zone.now, exp: expires_at }))
      end
    end

    class_methods do
    end
  end
end
