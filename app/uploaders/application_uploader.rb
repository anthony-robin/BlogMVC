class ApplicationUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  # Default files to use when missing ones
  # (in public/ folder)
  #
  # @return [String]
  def default_url
    '/fallback/' + [version_name, 'default.png'].compact.join('_')
  end

  # List of allowed extensions files
  #
  # @return [Array<String>]
  def extension_whitelist
    %w[jpg jpeg png]
  end

  # Filename of uploaded file
  #
  # @return [String]
  def filename
    "#{mounted_as}.jpg" if original_filename
  end

  # Folder to store uploaded files
  #
  # @return [String]
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"
  end
end
