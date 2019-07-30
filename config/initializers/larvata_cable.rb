# Override Owner class
LarvataCable.owner_class = 'User'

# Override User class
LarvataCable.user_class = 'User'

# Override authentication token column
LarvataCable.auth_token_column = 'auth_token'

# Add custom datetime format
Time::DATE_FORMATS[:f] = lambda { |time| time.strftime('%F') }
Time::DATE_FORMATS[:ym] = lambda { |time| time.strftime('%Y-%m') }
