class AccountsController < ApplicationController
  before_action :set_account, only: [ :show, :edit, :update, :destroy, :trigger ]

  # GET /accouts
  def index
    @accounts = Account.all.ordered
  end

  # GET /accouts/:id
  def show
    @transactions = @account.transactions.ordered.last(10)
  end

  # GET /accouts/new
  def new
    @account = Account.new
  end

  # POST /accouts/new
  def create
    @account = Account.new(account_params)
    if @account.save
      respond_to do |format|
        format.html { redirect_to accounts_path, notice: "Cuenta creada exitosamente." }
        format.turbo_stream { flash.now[:notice] = "Cuenta creada exitosamente." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /accouts/:id/edit
  def edit
  end

  # PUT /accouts/:id/edit
  def update
    if @account.update(account_params)
      redirect_to accounts_path, notice: "Cuenta actualizada correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /accouts/:id
  def destroy
    if @account.destroy
      redirect_to accounts_path, notice: "Cuenta eliminada correctamente."
    end
  end

  def trigger
    status, message = Accounts::TriggerEvent.new.call(@account, params[:event])
    if status
      redirect_to accounts_path, notice: "Estado de la cuenta cambiado exitosamente."
    else
      redirect_to accounts_path, status: :unprocessable_entity, notice: "No se ha podido validar el estado de la cuenta."
    end
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:user_id, :amount)
  end
end
