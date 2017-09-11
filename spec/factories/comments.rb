FactoryGirl.define do
  factory :comment do
    association :commentable, factory: :blog
    body { Faker::Lorem::sentence }
    user
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
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_user_id                              (user_id)
#
