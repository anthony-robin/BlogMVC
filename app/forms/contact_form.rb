class ContactForm < ApplicationForm
  # Properties
  properties :name, :email, :message, :copy, :nickname

  # Validation rules
  validates :name, presence: true
  validates :email,
            presence: true,
            email_format: true
  validates :message, presence: true
  validates :nickname, absence: true

  def initialize
    super OpenStruct.new
  end

  # Override these methods making them public to
  # avoid logs errors
  def persisted?
  end

  def to_key
  end
end
