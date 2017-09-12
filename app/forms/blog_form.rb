class BlogForm < ApplicationForm
  model :blog

  property :title, validates: { presence: true }
  property :content, validates: { presence: true }
  property :slug, writeable: false # Read only

  property :category_id
  property :tag_list

  property :picture do
    property :image
    property :image_cache
    property :_destroy
  end

  validates :category_id,
            presence: true,
            allow_blank: false,
            inclusion: {
              in: proc { Category.ids.map(&:to_s) }
            }
end
