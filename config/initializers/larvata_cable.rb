# Override expiration time/leeway claims for auth tokens
LarvataCable.exp_claim_time = 60 * 60
LarvataCable.leeway_claim = 60

# Add custom datetime format
Time::DATE_FORMATS[:f] = lambda { |time| time.strftime('%F') }
Time::DATE_FORMATS[:ym] = lambda { |time| time.strftime('%Y-%m') }
