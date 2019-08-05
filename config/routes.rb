LarvataCable::Engine.routes.draw do
  post 'login', defaults: { format: :json }, to: 'auth#create'
  delete 'logout', defaults: { format: :json }, to: 'auth#destroy'
end
