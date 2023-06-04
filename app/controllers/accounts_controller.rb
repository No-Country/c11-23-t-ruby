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
  end

  # POST /accouts/new
  def create
  end

  # GET /accouts/:id/edit
  def edit
  end

  # PUT /accouts/:id/edit
  def updated
  end

  # DELETE /accouts/:id
  def destroy
  end

  private

  def set_account
    @account = Account.find(params[:id])
  end
end
