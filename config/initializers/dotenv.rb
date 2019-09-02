env_keys = %w(
  DB_HOST
  DB_NAME
  DB_USER
  DB_PASSWORD
  REDIS_URL
  PRIVATE_KEY
  PUBLIC_KEY
)
Dotenv.require_keys(*env_keys)
