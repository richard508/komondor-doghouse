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
      distribute_user(@user)
      @user.send_new_user_welcome
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
      distribute_user(@user)
      redirect_to admin_users_path, notice: "User has been updated!"
    else
      render :edit
    end
  end

  def destroy
    # TODO: add archive feature
    User.find(params[:id]).destroy
    redirect_to admin_users_path, notice: "User has been deleted!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :account_id)
  end

  def distribute_user(user)
    if user.account
      user.apps.each do |app|
        DistributeUserJob.new(user.id, app.id).perform
      end
    end
  end
end
