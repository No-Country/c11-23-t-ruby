class AccountsController < ApplicationController
  before_action :set_account, only: [ :show, :edit, :update, :destroy ]

  # GET /accouts
  def index
    @accounts = Account.all
  end

  # GET /accouts/:id
  def show
  end

  # GET /accouts/new
  def new
    @account = Account.new
  end

  # POST /accouts/new
  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to accounts_path, notice: "Cuenta creada exitosamente."
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

  private

  def set_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:user_id, :amount)
  end
end
