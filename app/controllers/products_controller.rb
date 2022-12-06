class ProductsController < ApplicationController
  def show_all
    products = Product.all
    render json: products.to_json
  end
end
