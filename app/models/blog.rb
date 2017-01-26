class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category, counter_cache: true

  validates :title,
            presence: true
  validates :content,
            presence: true
  validates :category_id,
            presence: true,
            allow_blank: false,
            inclusion: {
              in: proc { Category.all.map(&:id) }
            }

  delegate :name, to: :category, prefix: true, allow_nil: true

  paginates_per 5

  def should_generate_new_friendly_id?
    slug.blank? || new_record? || title_changed?
  end
end
