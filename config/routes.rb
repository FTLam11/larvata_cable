LarvataCable::Engine.routes.draw do
  post 'auth', defaults: { format: :json }, to: 'auth#create'

  resources :chat_rooms, only: [:create, :index] do
    resources :messages, only: [:index]
    resources :members, controller: :chatters, only: [:create, :index, :destroy]
  end

  # TODO enable authentication for production sidekiq dashboard
  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
