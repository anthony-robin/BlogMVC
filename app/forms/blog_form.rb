class BlogForm < ApplicationForm
  model :blog

  # Properties
  property :title, validates: { presence: true }
  property :content, validates: { presence: true }
  property :slug, writeable: false # Read only

  property :tag_list
  property :category_id

  property :picture do
    property :image
    property :image_cache
    property :_destroy
  end

  # Validation rules
  validates :category_id,
            presence: true,
            allow_blank: false,
            inclusion: {
              in: proc { Category.ids.map(&:to_s) }
            }
end
