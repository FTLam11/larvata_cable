# Override expiration time/leeway claims for auth tokens
LarvataCable.exp_claim_time = 5 * 60
LarvataCable.leeway_claim = 60

# Add custom datetime format
Time::DATE_FORMATS[:f] = lambda { |time| time.strftime('%F') }
Time::DATE_FORMATS[:ym] = lambda { |time| time.strftime('%Y-%m') }

LarvataCable.auth_box = RbNaCl::SimpleBox.from_keypair(
  LarvataCable::AuthWrapper::READ_KEY.(ENV['PUBLIC_KEY']),
  LarvataCable::AuthWrapper::READ_KEY.(ENV['PRIVATE_KEY'])
)
