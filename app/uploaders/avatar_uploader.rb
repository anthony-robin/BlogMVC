class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  AVATAR_FILE_SIZE = 1

  retina!

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def default_url
    gravatar_id = Digest::MD5.hexdigest(model.email.downcase)
    "//gravatar.com/avatar/#{gravatar_id}.png?s=400&r=g&d=identicon"
  end

  version :large do
    process resize_to_fill: [400, 400]
  end

  version :medium do
    process resize_to_fill: [200, 200]
  end

  version :small do
    process resize_to_fill: [100, 100]
  end

  version :thumb do
    process resize_to_fill: [50, 50]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def size_range
    0..AVATAR_FILE_SIZE.megabytes
  end

  def filename
    "#{mounted_as}.jpg" if original_filename
  end
end
