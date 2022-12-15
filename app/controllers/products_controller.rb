class ProductsController < ApplicationController
  before_action :authenticate_admin, only: [:create, :update, :destroy]
  def index
    @products = Product.all
    render template: 'products/index'
  end

  def create_fake
    render json: Product.create_fake.deep_serialize
  end

  def create
    product = Product.new(
      params.permit(
        :name,
        :price,
        :description
      )
      .merge(
        supplier_id: params[:supplier]
      )
    )
    saved = product.save

    if saved
      render json: product.deep_serialize
    else
      render json: product.error_messages, status: :unprocessable_entity
    end
  end

  def show
    @product = Product.find_by(
      params.permit(:id)
    )
    if @product
      render template: 'products/show'
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
      updated = product.update(
        params.permit(
          :name,
          :price,
          :description
        )
        .merge(
          supplier_id: params[:supplier]
        )
      )
      if updated
        render json: product.deep_serialize
      else
        render json: "Failed to update product.".to_json, status: :internal_server_error
      end
    else
      render json: "Could not find product.".to_json
    end
  end

  def destroy
    product = Product.find_by(params.permit(:id))
    if product
      product.destroy
      if product.destroyed?
        render json: "Deleted product.".to_json
      else
        render json: "Failed to delete product.".to_json, status: :internal_server_error
      end
    else
      render json: "Could not find product.".to_json
    end
  end
end
