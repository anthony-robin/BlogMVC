class UserForm < ApplicationForm
  model :user

  properties :username, :email, :role
  property :password, virtual: true
  property :password_confirmation, virtual: true

  validates :username,
            presence: true,
            username_format: true,
            unique: {
              case_sensitive: false
            }

  validates :email,
            presence: true,
            email_format: true,
            unique: {
              case_sensitive: false
            }

  validates :password,
            presence: true,
            length: { minimum: 7 },
            if: -> { new_record? || changes[:crypted_password] }

  validates :password_confirmation,
            presence: true,
            if: -> { new_record? || changes[:crypted_password] }

  validate :password_ok?

  validates :role,
            presence: true,
            inclusion: { in: User.roles.keys },
            on: :update

  def password_ok?
    errors.add(:password, 'Password mismatch') if password != password_confirmation
  end
end
