class CreateAccountApps < ActiveRecord::Migration
  def change
    create_table :account_apps do |t|
      t.belongs_to :app, index: true
      t.belongs_to :account, index: true

      t.timestamps
    end
  end
end
