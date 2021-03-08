Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  get     '/yatchs'      to: 'yatchs#index'
  get     '/yatchs/:id'  to: 'yatchs#show'
  post    '/yatchs/:id'  to: 'yatchs#book'
  patch   '/yatchs/:id'  to: 'yatchs#edit'
  delete  '/yatchs/:id'  to: 'yatchs#destroy'

  patch   '/reviews/:id' to: 'reviews#update'

end
