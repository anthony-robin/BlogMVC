FactoryGirl.define do
  factory :comment do
    association :commentable, factory: :blog
    body Faker::Lorem::sentence
    user
  end
end
