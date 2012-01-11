class AddSmLinksToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_sm, :string
    add_column :users, :twitter_sm, :string
    add_column :users, :linkedin_sm, :string
  end
end
