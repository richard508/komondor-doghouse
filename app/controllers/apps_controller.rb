class AppsController < ApplicationController
  def show
    app = App.find(params[:id])
    redirect_to app_url(current_user, app)
  end
end
