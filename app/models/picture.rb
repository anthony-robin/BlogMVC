class Picture < ApplicationRecord
  belongs_to :attachable, polymorphic: true, touch: true

  mount_uploader :image, ImageUploader
  validates_integrity_of :image
end

# == Schema Information
#
# Table name: pictures
#
#  id              :integer          not null, primary key
#  attachable_type :string
#  attachable_id   :integer
#  image           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_pictures_on_attachable_type_and_attachable_id  (attachable_type,attachable_id)
#
