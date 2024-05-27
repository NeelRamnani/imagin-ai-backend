# app/controllers/users_controller.rb
class UsersController < ApplicationController
    before_action :authenticate_user!
  
    def show
      render json: {
        status: 200,
        message: 'User details retrieved successfully.',
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      }, status: :ok
    end
  end
  