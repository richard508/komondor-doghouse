class App < ActiveRecord::Base
  has_many :account_apps
  has_many :accounts, through: :account_apps

  validates :name, presence: true
  validates :url, presence: true
  validates :secret_key, presence: true

  def generate_secret_key
    self.secret_key = SecureRandom.urlsafe_base64(nil, false)
  end
end
