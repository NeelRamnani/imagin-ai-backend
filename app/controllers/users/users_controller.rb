# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :authenticate_user!

  # PUT /users/update_password
  def update_password
    if current_user.valid_password?(password_params[:current_password])
      if current_user.update(password_params.except(:current_password))
        render json: { message: 'Password updated successfully' }, status: :ok
      else
        render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['Current password is incorrect'] }, status: :unprocessable_entity
    end
  end

  # PUT /users/update
  def update
    if current_user.update_with_password(user_params)
      render json: { message: 'Profile updated successfully' }, status: :ok
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /users/name
  def name
    render json: { name: current_user.name }, status: :ok
  end

  # GET /users/details
  def details
    render json: {
      status: 200,
      message: 'User details retrieved successfully.',
      data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
    }, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:name, :current_password, :password, :password_confirmation)
  end

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
