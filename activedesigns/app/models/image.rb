class Image < ActiveRecord::Base
  belongs_to :project

  include Rails.application.routes.url_helpers
  mount_uploader :carimage, ImageUploader
  

	
  def to_jq_upload
  {
    "name" => read_attribute(:carimage),
    "size" => carimage.size,
    "url" => carimage.url,
    "thumbnail_url" => carimage.thumb.url,
    "delete_url" => image_path(:id => id),
    "delete_type" => "DELETE" 
   }
  end
	
	
end
