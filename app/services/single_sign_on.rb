class SingleSignOn
  def initialize user, message = nil
    @user = user
    @message = message
  end

  def signed_message
    "#{message}--#{signature}"
  end

  private

  def message
    @msg ||= begin
      data = @message || [@user.id, Time.now.utc]
      Base64.encode64(Marshal.dump(data)).gsub("\n", "")
    end
  end

  def signature
    OpenSSL::HMAC.hexdigest("sha1", ENV['IHUB_SECRET_KEY'], message)
  end
end
