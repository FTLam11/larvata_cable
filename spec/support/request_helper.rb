module RequestHelper
  def body_content
    JSON.parse(response.body)
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
  config.include LarvataCable::Engine.routes.url_helpers
end
