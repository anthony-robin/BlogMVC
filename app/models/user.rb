class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  # Carrierwave
  mount_uploader :avatar, AvatarUploader

  # Enum
  enum role: {
    master: 0,
    admin: 1,
    author: 2
  }, _suffix: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Model relations
  has_many :blogs, dependent: :destroy

  # Validation rules
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
#  role                   :integer          default("author")
#  blogs_count            :integer          default(0), not null
#  avatar                 :string
#  retina_dimensions      :text
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug)
#
