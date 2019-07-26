# Override Owner class
LarvataCable.owner_class = 'User'

# Override User class
LarvataCable.user_class = 'User'

# Add custom datetime format
Time::DATE_FORMATS[:f] = lambda { |time| time.strftime('%F') }
Time::DATE_FORMATS[:ym] = lambda { |time| time.strftime('%Y-%m') }
