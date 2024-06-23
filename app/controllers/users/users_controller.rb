# app/controllers/users_controller.rb
class UsersController< ApplicationController
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

  private

  def password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
      def show
        render json: { name: current_user.name, email: current_user.email }, status: :ok
      end

    def show
      render json: {
        status: 200,
        message: 'User details retrieved successfully.',
        data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
      }, status: :ok
    end
  end
  