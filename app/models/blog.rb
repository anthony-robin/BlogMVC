class Blog < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  include Searchable
  include Assets::Picturable

  # Model relations
  belongs_to :user, counter_cache: true
  belongs_to :category, counter_cache: true

  # Scopes
  scope :with_includes, -> { includes(:user, :category, :picture, :taggings) }
  scope :order_desc, -> { order(created_at: :desc) }

  # Delegates
  delegate :name, to: :category, prefix: true, allow_nil: true
  delegate :username, :role, to: :user, prefix: true, allow_nil: true

  # Pagination
  paginates_per 5

  acts_as_taggable # Tags
  acts_as_commentable # Comments

  private

  def should_generate_new_friendly_id?
    slug.blank? || new_record? || title_changed?
  end
end

# == Schema Information
#
# Table name: blogs
#
#  id             :integer          not null, primary key
#  title          :string
#  slug           :string
#  content        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :integer
#  user_id        :integer
#  comments_count :integer          default(0), not null
#
# Indexes
#
#  index_blogs_on_category_id  (category_id)
#  index_blogs_on_slug         (slug)
#  index_blogs_on_user_id      (user_id)
#
