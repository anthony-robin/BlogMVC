class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :blogs

  validates :name,
            presence: true,
            uniqueness: true

  paginates_per 5

  def should_generate_new_friendly_id?
    slug.blank? || new_record? || name_changed?
  end
end
