class CategoryForm < ApplicationForm
  model :category

  # Properties
  property :name, validates: { presence: true }
  property :slug, writeable: false # Read only

  # Validation rules
  validates :name, unique: true
end
