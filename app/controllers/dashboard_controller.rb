class DashboardController < ApplicationController
  before_action :sign_out_check
  before_action :signed_in_user
  def show

  end
end
