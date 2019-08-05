LarvataCable::Engine.routes.draw do
  post 'login', defaults: { format: :json }, to: 'auth#create'
end
