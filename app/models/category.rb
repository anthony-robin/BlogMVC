class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :blogs

  def should_generate_new_friendly_id?
    slug.blank? || new_record? || name_changed?
  end
end
