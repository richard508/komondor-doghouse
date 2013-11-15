class SessionsController < ApplicationController

  def new
    if current_user
      app = App.find_by(url: params[:referrer])
      redirect_to sign_in(current_user, app.id)
      return
    end
    if params[:referrer].blank?
      @app = OpenStruct.new(id: nil, name: 'iHub')
    else
      @app = App.find_by(url: params[:referrer])
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to sign_in(user, params[:referrer])
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
