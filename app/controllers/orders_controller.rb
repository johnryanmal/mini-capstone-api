class OrdersController < ApplicationController
  def index
    check_user do
      orders = Order.where(user_id: current_user.id)
      render json: orders.map { |order| order.deep_serialize }
    end
  end

  def create
    check_user do
      product = Product.find_by(id: params[:product_id])
      unless product
        render json: {msg: "Couldn't find product."}, status: :internal_server_error
      else
        order = Order.new(
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
        saved = order.save
        if saved
          render json: {msg: "Order created."}
        else
          render json: {msg: "Failed to create order."}, status: :internal_server_error
        end
      end
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
