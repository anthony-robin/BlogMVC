class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :blogs, dependent: :destroy, fully_load: true

  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  enum role: {
    master: 0,
    admin: 1,
    author: 2
  }, _suffix: true

  validates :username,
            presence: true,
            username_format: true,
            uniqueness: {
              case_sensitive: false
            }

  validates :email,
            presence: true,
            email_format: true,
            uniqueness: {
              case_sensitive: false
            }

  validates :role,
            presence: true,
            inclusion: { in: roles.keys },
            on: :update

  validates_integrity_of :avatar

  private

  def should_generate_new_friendly_id?
    new_record?
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
