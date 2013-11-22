module SessionsHelper

  def sign_in(user, referrer_id = nil)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
    unless referrer_id.blank? || referrer_id.nil?
      app = App.find(referrer_id)
      if app.accounts.include?(current_user.account)
        return app_url(current_user, app)
      else
        flash[:notice] = "Your account does not have access to this application."
      end
    end
    root_path
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
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def sign_out_check
    if params[:signout].present?
      sign_out
      if params[:referrer]
        redirect_to signin_path(referrer: params[:referrer])
      else
        redirect_to signin_path
      end
    end
  end

  def sign_out
    current_user.apps.each do |app|
      HTTParty.get("http://#{app.url}/sessions/signout?sig=#{Komondor::Sender.new(current_user, app).signed_message}")
    end
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def app_url(user, app)
    "http://#{app.url}/sessions/new?sig=#{Komondor::Sender.new(user, app).signed_message}"
  end
end
