module Blogs
  class SearchesController < ApplicationController
    before_action :redirect_to_blogs, if: -> { params[:term].blank? }
    before_action :set_categories, only: %i[index]

    def index
      @blogs = Blog.search(params[:term], Blog.search_opts.merge!(page: params[:page]))
      render template: 'blogs/index'
    end

    private

    def redirect_to_blogs
      redirect_to blogs_path
    end

    def set_categories
      @categories = Category.last(5)
    end
  end
end
