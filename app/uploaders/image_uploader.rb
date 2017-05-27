class ImageUploader < ApplicationUploader
  IMAGE_FILE_SIZE = 4

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.attachable_id}"
  end

  version :large_2x do
    process resize_to_fit: [1200, 1200]
  end

  version :large, from_version: :large_2x do
    process resize_to_fit: [600, 600]
  end

  version :medium_2x, from_version: :large do
    process resize_to_fit: [600, 600]
  end

  version :medium, from_version: :medium_2x do
    process resize_to_fit: [300, 300]
  end

  version :small_2x, from_version: :medium do
    process resize_to_fit: [300, 300]
  end

  version :small, from_version: :small_2x do
    process resize_to_fit: [150, 150]
  end

  version :thumb_2x, from_version: :small do
    process resize_to_fit: [100, 100]
  end

  version :thumb, from_version: :thumb_2x do
    process resize_to_fit: [50, 50]
  end

  def size_range
    0..IMAGE_FILE_SIZE.megabytes
  end
end
