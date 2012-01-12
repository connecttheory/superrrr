# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  
  
	

  # THIS IS USED BY THE PROJECT IMAGE UPLOADS
	# Include RMagick or MiniMagick support:
  include CarrierWave::RMagick
  include CarrierWave::MimeTypes
  # include CarrierWave::MiniMagick

  process :set_content_type
  
  process :quality => [75]
  def quality(q=75)
    manipulate! {|img| img.write(current_path) {self.quality=q}}
  end
	
  permissions 0777

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    #nil 
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end
  
  
  process :resize_to_limit => [780, 2000]
  
  #version :large do
    #process :resize_to_fill => [780, 526]
  #end

  # Create different versions of your uploaded files:
  version :thumb do
    process :resize_to_fill => [240, 140]
  end
  #version :wide_thumb do
  #  process :resize_to_fill => [375, 140]
  #end
  #version :wider_thumb do
  #  process :resize_to_fill => [780, 140]
  #end
  
  

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  
  # Set the max file size of uploaded images
  #def max_file_size
    #12000
  #end

end
