class CategoryForm < ApplicationForm
  model :category

  property :name, validates: { presence: true }
  property :slug, writeable: false # Read only

  validates :name, unique: true
end
