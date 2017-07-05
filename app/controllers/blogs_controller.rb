class BlogsController < ApplicationController
  include Blogs::Sidebarable

  # GET /blogs
  def index
    @blogs = Blog.with_includes.order_desc
    @blogs = @blogs.tagged_with(params[:tag]) if params[:tag]
    @blogs = @blogs.page params[:page]

    add_breadcrumb t('.title')
  end
end
