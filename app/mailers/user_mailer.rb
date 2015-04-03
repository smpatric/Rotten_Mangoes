class UserMailer < ApplicationMailer
  default from: 'no-reply@rotten-mangoes.com'
  
  def account_deleted_email(user)
    @user = user
    mail(to: @user, subject: 'Account Deleted')
  end

end
