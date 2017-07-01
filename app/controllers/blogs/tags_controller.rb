module Blogs
  class TagsController < ApplicationController
    include Blogs::Sidebarable

    add_breadcrumb I18n.t('blogs.index.title'), :blogs_path

    # GET /blogs/tags/:id
    def show
      @blogs = Blog.with_includes.includes(:category).order_desc
      @blogs = @blogs.tagged_with(params[:id]).page params[:page]

      add_breadcrumb t('.title', tag: params[:id])
      render template: 'blogs/index'
    end
  end
end
