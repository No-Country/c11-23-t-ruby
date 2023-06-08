class UserMailer < ApplicationMailer
  def new_account_email
    @user = params[:user]
    @account = params[:account]

    mail to: @user.email, subject: "Cuenta de Own Bank creada."
  end

  def account_status_change_email
    @user = params[:user]
    @account = params[:account]

    mail to: @user.email, subject: "El estado de su cuenta Own Bank ha cambiado."
  end

  def new_transaction_email
    @user = params[:user]
    @account = params[:account]
    @transaction = params[:transaction]

    mail to: @user.email, subject: "Nueva transaccion."
  end

  def new_loan_email
    @user = params[:user]
    @account = params[:account]
    @loan = params[:loan]

    mail to: @user.email, subject: "Nueva solicitud de prestamo."
  end
end
