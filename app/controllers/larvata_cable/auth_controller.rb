module LarvataCable
  class AuthController < ApplicationController
    include LarvataCable::UserFindable

    before_action :set_user

    def create
      @user.generate_token

      render json: {
        access_token: @user.send(LarvataCable.auth_token_column),
        token_type: 'bearer',
        expires_in: 3600
      }
    end

    def destroy
    end

    private

    def set_user
      if @user = find_verified_user do
        LarvataCable.user_class.send("find_by_#{LarvataCable.user_account_column.to_s}",
                                     params[LarvataCable.user_account_column])
      end
        @user
      else
        render json: {}, status: 400 and return
      end
    end
  end
end
