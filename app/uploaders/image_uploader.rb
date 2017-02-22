class ImageUploader < ApplicationUploader
  IMAGE_FILE_SIZE = 4

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.attachable_id}"
  end

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

  def size_range
    0..IMAGE_FILE_SIZE.megabytes
  end
end
