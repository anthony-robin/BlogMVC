class BlogsController < ApplicationController
  # Callbacks
  before_action :set_category, only: %i[index],
                if: proc { params[:category_id].present? }
  before_action :set_categories, only: %i[index show]

  # Abilities
  load_and_authorize_resource find_by: :slug

  # Breadcrumbs
  add_breadcrumb I18n.t('blogs.index.title'), :blogs_path

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.with_includes.order_desc
    @blogs = @category.blogs.includes(:user, :category) if params[:category_id].present?
    @blogs = @blogs.tagged_with(params[:tag]) if params[:tag]
    @blogs = @blogs.page params[:page]

    add_breadcrumb @category.name if params[:category_id].present?
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @commentable = @blog
    comment_threads = @commentable.comment_threads
    @comments = comment_threads.includes(:user, :commentable).order(created_at: :desc)

    @form = CommentForm.new(comment_threads.new)
    add_breadcrumb t('.title', title: @blog.title)
  end

  private

  def set_category
    @category = Category.friendly.find(params[:category_id])
  end

  def set_categories
    @categories = Category.last(5)
  end
end
