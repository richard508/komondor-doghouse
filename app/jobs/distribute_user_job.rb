class DistributeUserJob
  class NewUserNotCreated < StandardError; end
  attr_reader :user_id, :app_id
  def initialize user_id, app_id
    @user_id = user_id
    @app_id = app_id
  end

  def perform
    user = User.find(user_id)
    app = App.find(app_id)
    Rails.logger.debug "http://#{app.url}/users/new_from_provider?sig=#{SingleSignOn.new(user, app, message(user)).signed_message}"
    response = HTTParty.get "http://#{app.url}/users/new_from_provider?sig=#{SingleSignOn.new(user, app, message(user)).signed_message}"
    raise NewUserNotCreated if response.code != 201
  end

  private

  def message(user)
    {
      identity_id: user.id,
      name: user.name,
      email: user.email,
      time: Time.now.utc
    }
  end
end
