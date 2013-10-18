class SessionsController < ApplicationController

  def new
    if params[:referrer].present?
      @app = App.find_by(url: params[:referrer])
    else
      @app = OpenStruct.new(id: nil, name: 'iHub')
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_back_or sign_in(user, params[:referrer])
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
