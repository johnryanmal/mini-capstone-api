class ProductsController < ApplicationController
  def index
    render json: Product.all.map{ |product| product.serialize }
  end

  def create_fake
    render json: Product.create_fake.serialize
  end

  def create
    render json: Product.create(
      params.permit(
        :name,
        :price,
        :image_url,
        :description
      )
    ).serialize
  end

  def show
    product = Product.find_by(
      params.permit(:id)
    )
    if product
      render json: product.serialize
    else
      p 'not found'
      render json: "Could not find product.".to_json
    end
  end

  def update
    product = Product.find_by(
      params.permit(:id)
    )
    if product
      product.update(
        params.permit(
          :name,
          :price,
          :image_url,
          :description
        )
      )
      render json: product.serialize
    else
      render json: "Could not find product.".to_json
    end
  end

  def destroy
    product = Product.find_by(params.permit(:id))
    if product
      product.destroy
      render json: "Deleted product.".to_json
    else
      render json: "Could not find product.".to_json
    end
  end
end
