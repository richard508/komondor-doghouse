class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = self.class.encrypt(self.class.new_remember_token)
  end
end
