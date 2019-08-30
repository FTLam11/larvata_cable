require 'jwt'

module LarvataCable
  module JWTWrapper
    extend self

    SIGNING_KEY = Rails.application.secrets[:jwt_signing_key]

    unless SIGNING_KEY.present?
      raise 'Please set jwt_signing_key in config/secrets.yml. It is required for signing JWT. Refer to https://jwt.io/introduction.'
    end

    def encode(payload)
      JWT.encode(payload, SIGNING_KEY, 'HS256')
    end

    def decode(token)
      JWT.decode(token, SIGNING_KEY, true, {
        exp_leeway: LarvataCable.leeway_claim, algorithm: 'HS256'
      }).first
    end

    def generate_token(user)
      expires_at = Time.zone.now.to_i + LarvataCable.exp_claim_time

      encode(
        {
          sub: user.host_user_id,
          aud: user.tenant_id,
          exp: expires_at
        }
      )
    end
  end
end
