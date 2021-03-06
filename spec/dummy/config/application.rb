require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)
Dotenv::Railtie.load
require 'larvata_cable'
require 'anycable-rails'

module Dummy
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.after_initialize do |config|
      Rails.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

