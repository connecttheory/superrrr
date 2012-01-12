class AddCustomImageThumbnailToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :custom_image_thumbnail, :integer
  end
end
