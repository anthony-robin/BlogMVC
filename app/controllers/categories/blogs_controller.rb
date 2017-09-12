module Categories
  class BlogsController < ApplicationController
    include Blogs::Sidebarable

    load_resource :category,
      find_by: :slug
    load_resource :blog,
      find_by: :slug,
      through: :category

    add_breadcrumb I18n.t('blogs.index.title'), :blogs_path

    # GET /categories/:category_id/blogs
    def index
      @blogs = @blogs.with_includes.page params[:page]
      add_breadcrumb @category.name

      render template: 'blogs/index'
    end

    # GET /categories/:category_id/blogs/:id
    def show
      @commentable = @blog
      comment_threads = @commentable.comment_threads
      @comments = comment_threads.includes(:user, :commentable).order(created_at: :desc)
      @form = CommentForm.new(comment_threads.new)

      add_breadcrumb t('.title', title: @blog.title)
    end
  end
end
