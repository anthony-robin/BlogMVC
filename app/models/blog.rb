class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category

  validates :title,
            presence: true
  validates :content,
            presence: true

  paginates_per 5

  def should_generate_new_friendly_id?
    slug.blank? || new_record? || title_changed?
  end
end
