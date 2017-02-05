class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
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
  delegate :username, :role, to: :user, prefix: true, allow_nil: true

  paginates_per 5

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
