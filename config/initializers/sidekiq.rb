module Sidekiq
  class Logger < ::Logger
    module Formatters
      class ExtraPretty < Pretty
        def call(severity, time, _program_name, message)
          "#{time.utc.iso8601(3)} pid=#{::Process.pid} tid=#{tid}#{format_context} [#{severity}] #{message}\n"
        end
      end
    end
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV["REDIS_URL"] }
end

Sidekiq.logger.formatter = Sidekiq::Logger::Formatters::ExtraPretty.new
