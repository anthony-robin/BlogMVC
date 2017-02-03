class User < ApplicationRecord
  extend FriendlyId
  friendly_id :username, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :blogs, dependent: :destroy

  def should_generate_new_friendly_id?
    new_record?
  end
end
