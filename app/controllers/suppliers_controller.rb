class SuppliersController < ApplicationController
  def index
    render json: Supplier.all
  end

  def create_fake
    render json: Supplier.create_fake
  end

  def create
    supplier = Supplier.new(
      params.permit(
        :name,
        :email,
        :phone_number
      )
    )
    saved = supplier.save

    if saved
      render json: supplier.serialize
    else
      render json: supplier.error_messages, status: :unprocessable_entity
    end
  end

  def show
    supplier = Supplier.find_by(
      params.permit(:id)
    )
    if supplier
      render json: supplier.serialize
    else
      p 'not found'
      render json: "Could not find supplier.".to_json
    end
  end

  def update
    supplier = Supplier.find_by(
      params.permit(:id)
    )
    updated = supplier.update(
      params.permit(
        :name,
        :email,
        :phone_number
      )
    )
    if updated
      render json: supplier.serialize
    else
      render json: "Could not find supplier.".to_json
    end
  end

  def destroy
    supplier = Product.find_by(params.permit(:id))
    if supplier
      supplier.destroy
      if supplier.destroyed?
        render json: "Deleted supplier.".to_json
      else
        render json: "Failed to delete supplier.".to_json, status: :internal_server_error
      end
    else
      render json: "Could not find supplier.".to_json
    end
  end
  
end
