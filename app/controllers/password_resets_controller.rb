class PasswordResetsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
      if user.present?
        reset_token = SecureRandom.urlsafe_base64
        user.reset_password_token = reset_token
        user.reset_password_sent_at = Time.zone.now
        user.save!
  
        # Send reset password email with the token
        UserMailer.reset_password(user, reset_token).deliver_now
      end
      head :ok
    end
  
    def edit
      @user = User.find_by(reset_password_token: params[:token], reset_password_sent_at: 2.hours.ago..Time.now)
    end
  
    def update
      @user = User.find_by(reset_password_token: params[:token], reset_password_sent_at: 2.hours.ago..Time.now)
      if @user.present? && @user.update(password: params[:password])
        @user.update(reset_password_token: nil, reset_password_sent_at: nil)
        # Successful password reset
        redirect_to login_path, notice: 'Password reset successfully.'
      else
        render :edit, alert: 'Failed to reset password.'
      end
    end
  end