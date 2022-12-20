class CartedProductsController < ApplicationController
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
