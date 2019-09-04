module LarvataCable
  class AuthController < ApplicationController
    def create
      auth_service = LarvataCable::AuthorizeHost.new(params)

      if auth_service.success
        render json: { token: LarvataCable::JWTWrapper.generate_token(auth_service.user) }
      else
        render json: { error: auth_service.error }, status: 400 and return
      end
    end
  end
end
