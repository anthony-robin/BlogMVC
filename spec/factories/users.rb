FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { "#{username}@example.com" }
    password 'password'
    password_confirmation 'password'

    trait :master do
      role 0
    end

    trait :admin do
      role 1
    end

    trait :author do
      role 2
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  username               :string           default(""), not null
#  slug                   :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :integer          default("author")
#  blogs_count            :integer          default(0), not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug)
#
