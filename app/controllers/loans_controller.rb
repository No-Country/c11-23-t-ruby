class LoansController < ApplicationController
  before_action :set_account

  def new
    @loan = @account.loans.build
  end

  def create
    @loan = @account.loans.build(loan_params)
    if @loan.save
      respond_to do |format|
        format.html { redirect_to account_path(@account), notice: "Prestamo solicitado correctamente." }
        format.turbo_stream { flash.now[:notice] = "Prestamo solicitado correctamente." }
      end
    else
      render :new, status: :unprocessable_entity, notice: "No se ha podido solicitar el prestamo."
    end
  end

  private

  def set_account
    @account =  Account.find(params[:account_id])
  end

  def loan_params
    params.require(:loan).permit(:amount)
  end
end
