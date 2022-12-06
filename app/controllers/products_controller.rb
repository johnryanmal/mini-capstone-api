class ProductsController < ApplicationController
  def show_all
    products = Product.all
    render json: products.to_json
  end

  def show_one
    product = Product.find_by(id: params[:id])
    render json: product.to_json
  end
end
