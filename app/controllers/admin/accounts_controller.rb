class Admin::AccountsController < ApplicationController
  before_action :require_admin
  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to admin_accounts_path, notice: "New Account has been added!"
    else
      render :new
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      redirect_to admin_accounts_path, notice: "Account has been updated!"
    else
      render :edit
    end
  end

  def destroy
    Account.find(params[:id]).destroy
    redirect_to admin_accounts_path, notice: "Account has been deleted!"
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end
end
