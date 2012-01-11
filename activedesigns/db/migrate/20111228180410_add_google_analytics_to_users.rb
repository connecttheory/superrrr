class AddGoogleAnalyticsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :google_analytics, :string
  end
end
