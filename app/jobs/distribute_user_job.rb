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
    url = "http://#{app.url}/users/new?sig=#{Komondor::Sender.new(user, app, message(user)).signed_message}"
    response = HTTParty.get url
    #TODO deal with error case
    raise NewUserNotCreated, "Failed while talking to #{app.url}." if response.code != 201
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
