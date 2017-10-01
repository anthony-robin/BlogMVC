class SessionForm < ApplicationForm
  model :user

  property :email, validates: { presence: true }
  property :password, validates: { presence: true }

  validates :email, email_format: true
end
