module LarvataCable
  module UserFindable
    extend ActiveSupport::Concern

    included do
      def find_verified_user(&block)
        if (user = request.env['warden']&.user || (block.call if block_given?))
          user
        elsif decoded_token
          User.find(decoded_token['sub'])
        end
      end

      private

      def decoded_token
        JwtWrapper.decode(request_header_token)
      rescue JWT::DecodeError => e
        lawger('JWT Decode Error', "#{e.message}: #{request_header_token.inspect}")
        false
      end

      def request_header_token
        if request.headers['Authorization']&.match(/Bearer /)
          request.headers['Authorization'].split[1]
        end
      end

      def lawger(tag, message)
        if logger.respond_to?(:add_tags)
          logger.add_tags(tag, message)
        else
          logger.error("[#{tag}] #{message}")
        end
      end
    end

    class_methods do
    end
  end
end
