# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def reset_password_email
    user.update_attribute(:reset_password_token, Faker::Number.number(10))
    UserMailer.reset_password_email(user)
  end

  private

  def user
    @user ||= User.first
  end
end
