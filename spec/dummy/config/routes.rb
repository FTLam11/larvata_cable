Rails.application.routes.draw do
  mount LarvataCable::Engine => "/larvata_cable"
end
