class UserMailer < ApplicationMailer
  def new_account_email
    @user = params[:user]
    @account = params[:account]

    mail to: @user.email, subject: "Cuenta de Own Bank creada."
  end
end
