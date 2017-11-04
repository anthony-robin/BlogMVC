FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category#{n + 1}" }
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
