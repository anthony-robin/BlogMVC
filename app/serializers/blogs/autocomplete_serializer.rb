module Blogs
  class AutocompleteSerializer < ApplicationSerializer
    attributes :title, :url
    attribute :picture, if: -> { object.picture? }

    def url
      category_blog_path(object.category, object)
    end

    def picture
      retina_image_tag(object.picture, :image, :thumb)
    end
  end
end
