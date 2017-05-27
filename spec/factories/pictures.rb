FactoryGirl.define do
  factory :picture do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'avatar.png')) }

    trait :for_blog do
      association :attachable, factory: :blog
    end
  end
end

# == Schema Information
#
# Table name: pictures
#
#  id              :integer          not null, primary key
#  attachable_type :string
#  attachable_id   :integer
#  image           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_pictures_on_attachable_type_and_attachable_id  (attachable_type,attachable_id)
#
