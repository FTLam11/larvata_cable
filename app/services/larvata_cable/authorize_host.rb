module LarvataCable
  class AuthorizeHost
    attr_reader :success, :error, :tenant, :user, :data

    def initialize(params)
      json = AuthWrapper.parse_token(params)
      @tenant = Tenant.find(json['app_id'])
      @user = User.find_or_create_by!(host_user_id: json.dig('data', 'user_id'),
                                                    tenant: tenant)
      @data = json['data']
      @success = true
    rescue StandardError => e
      Rails.logger.tagged(self.class.name) { Rails.logger.error("#{e.message} #{json}") }
      @error = 'Unauthorized request'
    end
  end
end
