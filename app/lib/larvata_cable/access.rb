require 'jwt'

module LarvataCable
  module Access
    extend self

    def decode(token)
      JWT.decode(token, LarvataCable.signing_key, true, exp_leeway: LarvataCable.leeway_claim, algorithm: 'HS256').first
    end

    def generate_token(user)
      expires_at = Time.zone.now.to_i + LarvataCable.exp_claim_time

      encode(sub: user.id, aud: user.tenant_id, exp: expires_at)
    end

    private

    def encode(payload)
      JWT.encode(payload, LarvataCable.signing_key, 'HS256')
    end
  end
end
