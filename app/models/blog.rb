class Blog < ApplicationRecord
  validates :title,
            presence: true
  validates :content,
            presence: true

  paginates_per 5
end
