class OrdersController < ApplicationController
  def index
    check_user do
      orders = Order.where(user_id: current_user.id)
      render json: orders.map { |order| order.deep_serialize }
    end
  end

  def create
    product = Product.find_by(id: params[:product_id])
    pp product
    pp product.price
    pp product.tax
    pp product.total

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
        render json: order.deep_serialize
      else
        render json: {msg: "You don't have access to that order"}, status: :unauthorized
      end
    end
  end
end
