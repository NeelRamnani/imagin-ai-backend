# app/controllers/api/images_controller.rb
module Api
  class ImagesController < ApplicationController
    def create
      @image = Image.new(image_params)
  
      if @image.save
        render json: { success: true, message: 'Image saved successfully' }, status: :created
      else
        render json: { success: false, errors: @image.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def image_params
      params.require(:image).permit(:url)
    end
  end
end
