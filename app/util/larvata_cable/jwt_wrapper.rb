module LarvataCable
  module JWTWrapper
    extend self

    SIGNING_KEY = Rails.application.secrets[:jwt_signing_key]

    raise 'Please set jwt_signing_key in config/secrets.yml' unless SIGNING_KEY.present?

    def encode(payload)
      JWT.encode(payload, SIGNING_KEY, 'HS256')
    end

    def decode(token)
      JWT.decode(token, SIGNING_KEY, true, { algorithm: 'HS256' }).first
    end
  end
end
