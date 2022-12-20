class CartedProductsController < ApplicationController
  def index
    check_user do
      render json: CartedProduct.where(user_id: current_user.id, order_id: nil)
    end
  end

  def create
    check_user do
      render json: CartedProduct.create(
        params.permit(
          :product_id,
          :quantity
        )
        .merge(
          user_id: current_user.id,
          order_id: nil
        )
      )
    end
  end
end
