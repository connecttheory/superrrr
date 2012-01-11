class AddMaxImagesProjsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_capacity, :integer, :default => 30
    add_column :users, :project_capacity, :integer, :default => 3
  end
end
