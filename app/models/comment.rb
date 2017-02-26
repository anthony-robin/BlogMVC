class Comment < ApplicationRecord
  acts_as_nested_set scope: %i(commentable_id commentable_type)

  # Model relations
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  # Validation rules
  validates :body, presence: true
  validates :user, presence: true

  # Scopes
  scope :find_comments_by_user, lambda { |user|
    where(user_id: user.id).order('created_at DESC')
  }

  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  def has_children?
    self.children.any?
  end
end

# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_type :string
#  commentable_id   :integer
#  title            :string
#  body             :text
#  subject          :string
#  lft              :integer
#  rgt              :integer
#  parent_id        :integer
#  user_id          :integer
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_user_id                              (user_id)
#
