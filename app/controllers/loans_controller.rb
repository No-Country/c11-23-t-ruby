class LoansController < ApplicationController
  load_and_authorize_resource :account
  load_and_authorize_resource :loan, through: :account

  before_action :set_account
  before_action :set_loan, only: [:trigger]



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

  def trigger
    status, message = Loans::TriggerEvent.new.call(@loan, params[:event])
    if status
      respond_to do |format|
        format.html { redirect_to loans_path, notice: "Estado de la solicitud cambiada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "Estado de la solicitud cambiada exitosamente." }
      end
    else
      redirect_to loans_path, status: :unprocessable_entity, notice: "No se ha podido validar el estado de la solicitud."
    end
  end

  private

  def set_account
    @account =  Account.find(params[:account_id])
  end

  def set_loan
    @loan = @account.loans.find(params[:id])
  end

  def loan_params
    params.require(:loan).permit(:amount)
  end
end
