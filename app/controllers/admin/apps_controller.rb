class Admin::AppsController < ApplicationController
  before_action :require_admin
  def index
    @apps = App.all
  end

  def show
    @app = App.find(params[:id])
  end

  def new
    @app = App.new
  end

  def create
    @app = App.new(app_params)
    @app.generate_secret_key
    if @app.save
      redirect_to admin_apps_path, notice: "New App has been added!"
    else
      render :new
    end
  end

  def edit
    @app = App.find(params[:id])
  end

  def update
    @app = App.find(params[:id])
    if @app.update(app_params)
      redirect_to admin_apps_path, notice: "App has been updated!"
    else
      render :edit
    end
  end

  def destroy
    App.find(params[:id]).destroy
    redirect_to admin_apps_path, notice: "App has been deleted!"
  end

  def regenerate_key
    app = App.find(params[:id])
    app.generate_secret_key
    if app.save
      flash[:notice] = "New secret key generated."
    else
      flash[:error] = "Secret key not updated."
    end
    redirect_to admin_app_path(app)
  end

  private

  def app_params
    params.require(:app).permit(:name, :url, account_ids: [])
  end
end
