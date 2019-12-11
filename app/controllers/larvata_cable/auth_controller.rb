module LarvataCable
  class AuthController < ApplicationController
    def create
      auth_service = AuthorizeHost.new(params)

      if auth_service.success
        render json: { token: JwtWrapper.generate_token(auth_service.user) }
      else
        render json: { error: auth_service.error }, status: 400
      end
    end
  end
end
