class AvatarUploader < ApplicationUploader
  AVATAR_FILE_SIZE = 1

  def default_url
    gravatar_id = Digest::MD5.hexdigest(model.email.downcase)
    "//gravatar.com/avatar/#{gravatar_id}.png?s=400&r=g&d=identicon"
  end

  version :large_2x do
    process resize_to_fill: [400, 400]
  end

  version :large, from_version: :large_2x do
    process resize_to_fill: [200, 200]
  end

  version :small_2x, from_version: :large do
    process resize_to_fill: [200, 200]
  end

  version :small, from_version: :small_2x do
    process resize_to_fill: [100, 100]
  end

  def size_range
    0..AVATAR_FILE_SIZE.megabytes
  end
end
