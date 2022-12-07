Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/products' => 'products#index'
  post '/products' => 'products#create'
  get '/product/:id' => 'products#show'
  patch '/product/:id' => 'products#update'
  delete '/product/:id' => 'products#destroy'
end
