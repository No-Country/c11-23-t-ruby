class TransactionsController < ApplicationController
  before_action :set_account
  before_action :set_new_transactiom, only: [ :deposit, :transfer, :withdraw ]

  def deposit
  end

  def transfer
  end

  def withdraw
  end

  def create
    @transaction = @account.transactions.build(transaction_params)
    if @transaction.save
      redirect_to account_path(@account), notice: "Deposito realizado exitosamente."
    else
      render :deposit, status: :unprocessable_entity
    end
  end

  private

  def set_new_transactiom
    @transaction = @account.transactions.build
  end

  def set_account
    @account = Account.find(params[:account_id])
  end

  def transaction_params
    params.require(:transaction).permit(:transaction_type, :amount, options: [:target_account, :from_account])
  end
end