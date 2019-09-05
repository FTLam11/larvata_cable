module Sidekiq
  class Logger < ::Logger
    module Formatters
      class ExtraPretty < Base
        def call(severity, time, program_name, message)
          "#{time.utc.iso8601(3)} pid=#{::Process.pid} tid=#{tid}#{format_context} [#{severity}] #{message}\n"
        end
      end
    end
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
  config.log_formatter = Sidekiq::Logger::Formatters::ExtraPretty.new
  config.logger.formatter = config.log_formatter
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end
