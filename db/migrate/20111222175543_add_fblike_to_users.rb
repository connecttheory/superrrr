class AddFblikeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fb_like, :boolean, :default => false
  end
end
