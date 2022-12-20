Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/products' => 'products#index'
  post '/products' => 'products#create'
  get '/products/:id' => 'products#show'
  patch '/products/:id' => 'products#update'
  delete '/products/:id' => 'products#destroy'

  get '/suppliers' => 'suppliers#index'
  post '/suppliers' => 'suppliers#create'
  get '/suppliers/:id' => 'suppliers#show'
  patch '/suppliers/:id' => 'suppliers#update'
  delete '/suppliers/:id' => 'suppliers#destroy'

  get "/images/:id" => "images#show"

  post "/users" => "users#create"

  post "/sessions" => "sessions#create"

  get "/orders" => "orders#index"
  post "/orders" => "orders#create"
  get "/orders/:id" => "orders#show"

  get "/carted-products" => "carted_products#index"
  post "/carted-products" => "carted_products#create"
  delete "/carted-products/:id" => "carted_products#destroy"
end
