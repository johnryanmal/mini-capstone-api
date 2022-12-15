class ImagesController < ApplicationController
  def create
    render json: Image.create(params.permit(:url))
  end

  def show
    render json: Image.find_by(params.permit(:id))
  end

  def update
    image = Image.find_by(params.permit(:id))
    unless image
      render json: {msg: "Could not find image."}, status: :internal_server_error
    else
      updated = image.update(params.permit(:url))
      if updated
        render json: {msg: "Update image."}
      else
        render json: {msg: "Failed to update image."}, status: :internal_server_error
      end
    end
  end

  def destroy
    image = Image.find_by(params.permit(:id))
    unless image
      render json: {msg: "Could not find image."}, status: :internal_server_error
    else
      image.destroy
      if image.destroyed?
        render json: {msg: "Deleted image."}
      else
        render json: {msg: "Failed to delete image."}, status: :internal_server_error
      end
    end
  end
end
