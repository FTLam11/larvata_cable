# Override expiration time/leeway claims for auth tokens
LarvataCable.exp_claim_time = 5 * 60
LarvataCable.leeway_claim = 60

# Add custom datetime format
Time::DATE_FORMATS[:f] = lambda { |time| time.strftime('%F') }
Time::DATE_FORMATS[:ym] = lambda { |time| time.strftime('%Y-%m') }

LarvataCable.auth_box = RbNaCl::SimpleBox.from_keypair(
  LarvataCable::AuthWrapper.read_key(ENV['PUBLIC_KEY']),
  LarvataCable::AuthWrapper.read_key(ENV['PRIVATE_KEY'])
)

LarvataCable.signing_key = Rails.application.secrets[:jwt_signing_key] ||
  Rails.application.credentials[:jwt_signing_key] || ENV['JWT_SIGNING_KEY']

unless LarvataCable.signing_key.present?
  raise 'Please set jwt_signing_key in config/secrets.yml or config/credentials.yml.enc. Refer to https://jwt.io/introduction.'
end
