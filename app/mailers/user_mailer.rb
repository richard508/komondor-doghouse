class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(user)
    @user = user
    mail to: @user.email, subject: "Password Reset"
  end

  def new_user_welcome(user)
    @user = user
    mail to: @user.email, subject: "Welcome New User"
  end
end
