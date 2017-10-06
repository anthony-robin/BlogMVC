module Blogs
  class SearchesController < ApplicationController
    before_action -> { redirect_to blogs_path },
      if: -> { params[:term].blank? }

    include Blogs::Sidebarable

    add_breadcrumb I18n.t('blogs.searches.index.title'), :blogs_searches_path

    # GET /blogs/searches/:term
    # @example /blogs/searches/paris
    def index
      opts = Blog.search_opts
      opts[:page] = params[:page]
      opts[:includes] = opts[:includes] << :user

      @blogs = Blog.search params[:term], opts

      render template: 'blogs/index'
    end
  end
end
