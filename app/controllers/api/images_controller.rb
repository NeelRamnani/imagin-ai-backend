class Api::ImagesController < ApplicationController
  def index
    user_id = params[:user_id]
    images = Image.where(user_id: user_id).with_attached_image_file
    render json: images.map { |image| image_with_attachment(image) }
  end

  def create
    image = Image.new(image_params)
    image.user_id = params[:image][:user_id]

    if image.save
      render json: image_with_attachment(image), status: :created
    else
      render json: { errors: image.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def image_params
    params.require(:image).permit(:prompt, :image_file)
  end

  def image_with_attachment(image)
    {
      id: image.id,
      prompt: image.prompt,
      image_file_url: image.image_file.attached? ? url_for(image.image_file) : nil
    }
  end
end
