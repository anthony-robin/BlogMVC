class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title,
            presence: true
  validates :content,
            presence: true

  paginates_per 5
end
