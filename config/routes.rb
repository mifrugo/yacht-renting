Rails.application.routes.draw do
  # User routes

  devise_scope :user do
    put '/users/avatar', to: 'update_users#update_avatar'
    put '/users/email', to: 'update_users#update_email'
    put '/users/password', to: 'update_users#update_password'
    get '/users/:id/yachts', to: 'yachts#user_list', as: :yacht_user
  end

  devise_for :users

  # Homepage
  root to: 'pages#home'

  # Yatchs listing
  get     '/yachts',              to: 'yachts#index'
  # New yacht
  get     '/yachts/new',          to: 'yachts#new'
  post    '/yachts',              to: 'yachts#create'

  
  # Book a yatch
  post    '/bookings/yacht/:id',  to: 'bookings#create', as: :yacht_bookings
  get     '/bookings',            to: 'yachts#user_bookings', as: :users_bookings
  

  get     '/yachts/search',       to: 'yachts#search'

  # Add to favorite
  post    '/yachts/:id/favorite',  to: 'favorites#add', as: :user_favorite

  # Update listing
  patch   '/yachts/:id',          to: 'yachts#update'
  get     '/yachts/:id/edit',     to: 'yachts#edit', as: :yacht_edit
  # Remove listing
  delete  '/yachts/:id',          to: 'yachts#destroy'
  # Single yatch
  get     '/yachts/:id',          to: 'yachts#show', as: 'yacht'


  # Update review

  post    '/reviews/:yacht_id',    to: 'reviews#create', as: :yacht_reviews
  delete  '/reviews/:id',          to: 'reviews#destroy', as: :review_delete

  # Add to favorite
  #post    '/yatchs/:id/favorite', to: 'favorite#add'
  get '/favorites',             to: 'yachts#user_favorite', as: :users_favorite
  # Delete favorite
  delete '/favorites/:id',       to: 'favorites#destroy', as: :favorite

  # Conversations list
  #get '/messages',               to: 'messages#list'
  # Single conversation
  #get '/messages/:id',           to: 'messages#show'
  # Add new message to conversation
  #post '/messages/:id',          to: 'messages#add'
end
