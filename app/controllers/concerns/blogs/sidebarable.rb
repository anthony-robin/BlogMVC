module Blogs
  module Sidebarable
    extend ActiveSupport::Concern

    # TODO: Find a way to replace this code by cancancan
    # `load_resource` method
    included do
      before_action :set_sidebar_categories
    end

    def set_sidebar_categories
      @categories = Category.last(5)
    end
  end
end
