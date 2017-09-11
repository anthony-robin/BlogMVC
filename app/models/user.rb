class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  has_many :blogs, dependent: :destroy

  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  attr_accessor :password_confirmation

  enum role: {
    master: 0,
    admin: 1,
    author: 2
  }, _suffix: true

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
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  username                        :string           not null
#  slug                            :string           not null
#  crypted_password                :string
#  salt                            :string
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  role                            :integer          default("author")
#  blogs_count                     :integer          default(0), not null
#  avatar                          :string
#  comments_count                  :integer          default(0), not null
#
# Indexes
#
#  index_users_on_email                 (email)
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#  index_users_on_slug                  (slug)
#
