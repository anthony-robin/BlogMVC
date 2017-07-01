module Blogs
  class SearchesController < ApplicationController
    before_action -> { redirect_to blogs_path },
      if: -> { params[:term].blank? }

    load_resource :category, parent: false

    def index
      @blogs = Blog.search(params[:term], Blog.search_opts.merge!(page: params[:page]))
      @categories = @categories.last(5)

      render template: 'blogs/index'
    end
  end
end
