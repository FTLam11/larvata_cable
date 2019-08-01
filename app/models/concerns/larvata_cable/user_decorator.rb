module LarvataCable
  module UserDecorator
    extend ActiveSupport::Concern

    included do
      def generate_token
        update(LarvataCable.auth_token_column => LarvataCable::JWTWrapper.encode({ user_id: id }))
      end
    end

    class_methods do
    end
  end
end
