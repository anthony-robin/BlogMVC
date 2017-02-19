class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  retina!

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path('fallback/' + [version_name, 'default.png'].compact.join('_'))
  end

  # process scale: [200, 300]

  # def scale(width, height)
  #   resize_to_fill width, height
  # end

  version :large do
    process resize_to_fit: [200, 300]
  end

  version :large_square do
    process resize_to_fill: [370, 370]
  end

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def filename
    "#{mounted_as}.jpg" if original_filename
  end
end
