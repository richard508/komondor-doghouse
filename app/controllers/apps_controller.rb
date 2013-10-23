class AppsController < ApplicationController
  def show
    app = App.find(params[:id])
    redirect_to app_url(current_user, app)
  end

  def list
    user = User.find(params[:identity_id])
    @apps = user.apps
    render json: @apps, :callback => params[:callback]
  end
end
