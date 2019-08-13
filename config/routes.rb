LarvataCable::Engine.routes.draw do
  post 'login', defaults: { format: :json }, to: 'auth#create'
  delete 'logout', defaults: { format: :json }, to: 'auth#destroy'

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
