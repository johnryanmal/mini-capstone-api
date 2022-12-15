class OrdersController < ApplicationController
  def index
    check_user do
      orders = Order.where(user_id: current_user.id)
      render json: {orders: orders}
    end
  end

  def create
    product = Product.find_by(params.permit(:id))

    check_user do
      render json: Order.create(
        params
        .permit(
          :product_id,
          :quantity
        )
        .merge(
          user_id: current_user.id,
          subtotal: product.price,
          tax: product.tax,
          total: product.total
        )
      )
    end
  end

  def show
    check_user do
      order = Order.find_by(params.permit(:id))
      if order&.user_id == current_user.id
        render json: {order: order}
      else
        render json: {msg: "You don't have access to that order"}, status: :unauthorized
      end
    end
  end
end
