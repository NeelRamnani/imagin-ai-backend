class UserMailer < ApplicationMailer
  def reset_password(user, reset_token)
    @user = user
    @reset_token = reset_token

    mail to: user.email, subject: 'Reset your password'
  end
end