class Category < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :blogs, dependent: :destroy, fully_load: true

  paginates_per 5

  def should_generate_new_friendly_id?
    slug.blank? || new_record? || name_changed?
  end
end

# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  slug        :string
#  blogs_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_categories_on_slug  (slug) UNIQUE
#
