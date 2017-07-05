class ApplicationUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end

  def extension_whitelist
    %w[jpg jpeg png]
  end

  def filename
    "#{mounted_as}.jpg" if original_filename
  end

  # In public/ folder
  def default_url
    '/fallback/' + [version_name, 'default.png'].compact.join('_')
  end
end
