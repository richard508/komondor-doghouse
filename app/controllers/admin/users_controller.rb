class Admin::UsersController < ApplicationController
  before_action :require_admin
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "New User has been added!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User has been updated!"
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path, notice: "User has been deleted!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :account_id)
  end
end
