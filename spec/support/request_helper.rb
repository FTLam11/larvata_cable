module RequestHelper
  def body_content
    JSON.parse(response.body)
  end

  def off_day?(date)
    pick_date(date)["is_off"]
  end

  def pick_date(date)
    body_content["data"].flatten.detect { |day| day["date_id"] == date }
  end
end

RSpec.configure do |config|
  config.include RequestHelper, type: :request
  config.include LarvataTimesheet::Engine.routes.url_helpers
end
