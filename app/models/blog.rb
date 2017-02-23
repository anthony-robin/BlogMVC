class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include Assets::Picturable

  # Model relations
  belongs_to :user, counter_cache: true
  belongs_to :category, counter_cache: true

  # Validation rules
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

  # Delegates
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :username, :role, to: :user, prefix: true, allow_nil: true

  # Pagination
  paginates_per 5

  # Tags
  acts_as_taggable

  private

  def should_generate_new_friendly_id?
    slug.blank? || new_record? || title_changed?
  end
end

# == Schema Information
#
# Table name: blogs
#
#  id          :integer          not null, primary key
#  title       :string
#  slug        :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  user_id     :integer
#
# Indexes
#
#  index_blogs_on_category_id  (category_id)
#  index_blogs_on_slug         (slug)
#  index_blogs_on_user_id      (user_id)
#
