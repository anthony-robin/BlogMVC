FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    salt 'abcdef123456'
    role 2

    after(:build) do |u|
      u.crypted_password = Sorcery::CryptoProviders::BCrypt.encrypt(u.password, u.salt)
    end

    trait :master do
      role 0
    end

    trait :admin do
      role 1
    end

    trait :author do
      role 2
    end

    trait :with_lost_password do
      reset_password_token { Faker::Crypto.sha1 }
      reset_password_token_expires_at { Faker::Date.forward(14) }
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string           not null
#  username         :string           not null
#  slug             :string           not null
#  crypted_password :string
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  role             :integer          default("author")
#  blogs_count      :integer          default(0), not null
#  avatar           :string
#  comments_count   :integer          default(0), not null
#
# Indexes
#
#  index_users_on_email  (email)
#  index_users_on_slug   (slug)
#
