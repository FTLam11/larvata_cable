LarvataCable::Engine.routes.draw do
  post 'auth', defaults: { format: :json }, to: 'auth#create'

  resources :chat_rooms, only: [:create, :index]

  # TODO enable authentication for production sidekiq dashboard
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
