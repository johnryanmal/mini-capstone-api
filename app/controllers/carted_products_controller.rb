class CartedProductsController < ApplicationController
  def index
    check_user do
      render json: CartedProduct.where(user_id: current_user.id, order_id: nil).map(&:deep_serialize)
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
          user_id: current_user.id
        )
      )
    end
  end

  def destroy
    check_user do
      carted_product = CartedProduct.find_by(params.permit(:id))
      unless carted_product
        render json: {msg: "Couldn't find carted product."}, status: :internal_server_error
      else
        if carted_product.user_id == current_user.id
          carted_product.destroy
          if carted_product.destroyed?
            render json: { msg: "Deleted carted product."}
          else
            render json: { msg: "Failed to delete carted product."}, status: :internal_server_error
          end
        else
          render json: {msg: "You don't have access to that carted product."}, status: :unauthorized
        end
      end
    end
  end

end
