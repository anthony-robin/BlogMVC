class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  IMAGE_FILE_SIZE = 4

  retina!

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.attachable_id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'default.png'].compact.join('_'))
  end

  # process scale: [200, 300]

  # def scale(width, height)
  #   resize_to_fill width, height
  # end

  version :large do
    process resize_to_fit: [512, 512]
  end

  version :medium do
    process resize_to_fit: [256, 256]
  end

  version :small do
    process resize_to_fit: [100, 100]
  end

  version :thumb do
    process resize_to_fit: [50, 50]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def size_range
    0..IMAGE_FILE_SIZE.megabytes
  end

  def filename
    "#{mounted_as}.jpg" if original_filename
  end
end
