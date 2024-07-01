

class Api::ImagesController < ApplicationController
 
  def create
    @image = Image.new(image_params)

    if @image.save
      render json: @image, status: :created
    else
      render json: { errors: @image.errors.full_messages }, status: :unprocessable_entity
    end
  end
  def index
    user_id = params[:user_id]
    images = Image.where(user_id: user_id)
    render json: images, status: :ok
  end
  private

  def image_params
    params.require(:image).permit(:image_file, :prompt, :user_id)
  end
end
