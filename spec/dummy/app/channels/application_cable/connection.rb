require 'jwt'

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'Action Cable', "User #{current_user.id}"
    end

    private

    def find_verified_user
      if decoded_token
        LarvataCable.user_class.find(decoded_token['user_id'])
      else
        reject_unauthorized_connection
      end
    end

    def decoded_token
      @token ||= JWT.decode(request_header_token, Rails.application.secrets[:secret_key_base], true, { algorithm: 'HS256' }).first
    rescue JWT::DecodeError => e
      logger.add_tags 'Invalid auth token', "#{e.message}: #{request_header_token.inspect}"
      false
    end

    def request_header_token
      @raw_token = if env['HTTP_AUTHORIZATION']&.match(/Bearer /)
        env['HTTP_AUTHORIZATION'].split[1]
      end
    end
  end
end
