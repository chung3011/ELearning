class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.mail, subject: "Activate"
  end

  def password_reset user
    @user = user
    mail to: user.mail, subject: "Reset password"
  end
end
