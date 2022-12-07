class ProductsController < ApplicationController
  def index
    render json: Product.all
  end

  def create_fake
    render json: Product.create_fake
  end

  def create
    render json: Product.create(
      params.permit(
        :name,
        :price,
        :image_url,
        :description
      )
    )
  end

  def show
    product = Product.find_by(
      params.permit(:id)
    )
    if product
      render json: product
    else
      p 'not found'
      render text: "Could not find product."
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
      render json: product
    else
      render text: "Could not find product."
    end
  end

  def destroy
    product = Product.find_by(params.permit(:id))
    if product
      product.destroy
      render text: "Deleted product."
    else
      render text: "Could not find product."
    end
  end
end
