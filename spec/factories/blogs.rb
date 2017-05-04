FactoryGirl.define do
  factory :blog do
    sequence(:title) { |n| "My title #{n + 1}" }
    content { Faker::Lorem.paragraph(2) }
    category
    user

    trait :author do
      association :user, factory: %i[user author]
    end

    trait :admin do
      association :user, factory: %i[user admin]
    end

    trait :master do
      association :user, factory: %i[user master]
    end
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
