FactoryGirl.define do
  factory :blog do
    sequence(:title) { |n| "My title #{n + 1}" }
    content { Faker::Lorem.paragraph(2) }
    category
    user
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
#  category_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_blogs_on_category_id  (category_id)
#  index_blogs_on_slug         (slug)
#  index_blogs_on_user_id      (user_id)
#
