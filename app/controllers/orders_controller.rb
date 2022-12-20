class OrdersController < ApplicationController
  before_action :authenticate_user, only: [:index, :show, :create]

  def index
    check_user do
      orders = Order.where(user_id: current_user.id)
      render json: orders.map { |order| order.deep_serialize }
    end
  end

  # def create
  #   check_user do
  #     product = Product.find_by(id: params[:product_id])
  #     unless product
  #       render json: {msg: "Couldn't find product."}, status: :internal_server_error
  #     else
  #       quantity = params[:quantity]
  #       order = Order.new(
  #         params
  #         .permit(
  #           :product_id,
  #           :quantity
  #         )
  #         .merge(
  #           user_id: current_user.id,
  #           subtotal: product.price * quantity,
  #           tax: product.tax * quantity,
  #           total: product.total * quantity
  #         )
  #       )
  #       saved = order.save
  #       if saved
  #         render json: {msg: "Order created."}
  #       else
  #         render json: {msg: "Failed to create order."}, status: :internal_server_error
  #       end
  #     end
  #   end
  # end

  def create
    check_user do
      carted_products = CartedProduct.where(user_id: current_user.id, order_id: nil)
      if carted_products.empty?
        render json: {msg: "Your cart is empty."}, status: :internal_server_error
      else
        subtotal = 0
        carted_products.each do |carted_product|
          subtotal += carted_product.product.price * carted_product.quantity
        end
        tax = subtotal * 0.09
        total = subtotal + tax

        order = Order.new(
          user_id: current_user.id,
          subtotal: subtotal,
          tax: tax,
          total: total
        )
        saved = order.save

        if saved
          carted_products.each do |carted_product|
            carted_product.update(order_id: order.id)
          end
          render json: order
        else
          render json: order.errors.full_messages
        end
      end
    end
  end

  def show
    check_user do
      order = Order.find_by(params.permit(:id))
      unless order
        render json: {msg: "Couldn't find order."}, status: :internal_server_error
      else
        if order.user_id == current_user.id
        render json: order.deep_serialize
        else
          render json: {msg: "You don't have access to that order"}, status: :unauthorized
        end
      end
    end
  end
end
