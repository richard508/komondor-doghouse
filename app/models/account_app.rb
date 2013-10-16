class AccountApp < ActiveRecord::Base
  belongs_to :app
  belongs_to :account
end
