module LarvataCable
  class AuthorizeHost
    attr_reader :success, :error, :token

    def initialize(params)
      begin
        json = LarvataCable::AuthWrapper.parse_token(params)
        tenant = LarvataCable::Tenant.find(json['app_id'])
        user = LarvataCable::User.find_or_create_by(host_user_id: json.dig(*%w(data user_id)),
                                                    tenant: tenant)
        @token = LarvataCable::JWTWrapper.generate_token(user)
        @success = true
      rescue StandardError => e
        # TODO setup logger/external error notification
        Rails.logger.error(e.message)
        @error = e.message
      end
    end
  end
end
