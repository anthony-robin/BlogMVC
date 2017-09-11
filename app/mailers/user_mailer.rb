class UserMailer < ApplicationMailer
  # Send a reset password email to a {User user}
  #
  # @param user [User]
  def reset_password_email(user)
    @user = user
    @url  = edit_reset_password_url(@user.reset_password_token)

    mail to: @user.email
  end
end
