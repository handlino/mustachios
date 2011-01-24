# encoding: utf-8

class MustacheThemeImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file
  process :resize_to_fit => ['100%', '100%']
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Create different versions of your uploaded files:
  version :thumb do
     process :resize_to_fit => [64, 64]
  end
  
  version :small do
     process :resize_to_fit => [128, 128]
  end
  
end
