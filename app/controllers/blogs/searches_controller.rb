module Blogs
  class SearchesController < ApplicationController
    before_action -> { redirect_to blogs_path },
      if: -> { params[:term].blank? }

    include Blogs::Sidebarable

    # Breadcrumbs
    add_breadcrumb I18n.t('blogs.searches.index.title'), :blogs_searches_path

    # GET /blogs/searches/:term
    def index
      @blogs = Blog.search(params[:term], Blog.search_opts.merge!(page: params[:page]))

      render template: 'blogs/index'
    end
  end
end
