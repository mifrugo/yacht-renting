Rails.application.routes.draw do
  # User routes
  devise_for :users

  # Homepage
  root to: 'pages#home'

  # Yatchs listing
  get     '/yatchs',              to: 'yatchs#index'
  # Single yatch
  get     '/yatchs/:id',          to: 'yatchs#show'
  # Book a yatch
  post    '/yatchs/:id',          to: 'yatchs#book'
  # Update listing
  patch   '/yatchs/:id',          to: 'yatchs#edit'
  # Remove listing
  delete  '/yatchs/:id',          to: 'yatchs#destroy'
  # Update review
  patch   '/reviews/:id',         to: 'reviews#update'

  # Add to favorite
  #post    '/yatchs/:id/favorite', to: 'favorite#add'
  # Delete favorite
  #delete '/favorites/:id',       to: 'favorites#destroy'

  # Conversations list
  #get '/messages',               to: 'messages#list'
  # Single conversation
  #get '/messages/:id',           to: 'messages#show'
  # Add new message to conversation
  #post '/messages/:id',          to: 'messages#add'
end
