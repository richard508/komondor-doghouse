class Account < ActiveRecord::Base
  has_many :users
  has_many :account_apps
  has_many :apps, through: :account_apps
  validates :name, presence: true
end
