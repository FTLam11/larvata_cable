require 'factory_bot_rails' if Rails.env.test?
require 'sidekiq'
require 'devise'

module LarvataCable
  class Engine < ::Rails::Engine
    isolate_namespace LarvataCable

    config.to_prepare do
      LarvataCable.user_class.include(LarvataCable::UserDecorator)
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot
      g.factory_bot dir: 'spec/factories'
    end

    initializer "model_core.factories", :after => "factory_bot.set_factory_paths" do
      FactoryBot.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryBot)
    end
  end
end
