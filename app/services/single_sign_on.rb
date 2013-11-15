class SingleSignOn
  def initialize user, app, message = nil
    @user = user
    @message = message
    @app = app
  end

  def signed_message
    "#{message}--#{signature}"
  end

  private

  def message
    @msg ||= begin
      data = @message || [@user.id, Time.now.utc]
      Base64.urlsafe_encode64(Marshal.dump(data))
    end
  end

  def signature
    OpenSSL::HMAC.hexdigest("sha1", @app.secret_key, message)
  end
end
