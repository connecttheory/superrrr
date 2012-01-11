class AddSubdomainNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subdomain_name, :string
  end
end
