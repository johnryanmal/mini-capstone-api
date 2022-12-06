Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/products', controller: 'products', action: 'show_all'
  get '/product/:id', controller: 'products', action: 'show_one'
end
