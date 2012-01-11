class AddProjecturlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_url, :string
  end
end
