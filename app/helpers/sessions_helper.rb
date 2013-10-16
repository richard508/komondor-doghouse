module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token  = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    if session[:referring_app_id].present?
      app = App.find(session[:referring_app_id])
      redirect_to app_url(current_user, app)
      session.delete(:referring_app_id)
    else
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end
  end

  def app_url(user, app)
    "http://#{app.url}/sessions/new?sig=#{SingleSignOn.new(user, app).signed_message}"
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end

  def referring_app(app)
    session[:referring_app_id] = app.id unless app.nil?
  end
end
