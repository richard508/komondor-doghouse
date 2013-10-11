class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  protected
  def require_admin
    unless signed_in? && current_user.admin?
      redirect_to root_path, notice: "This is not the page you are looking for!"
    end
  end
end
