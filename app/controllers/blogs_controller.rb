class BlogsController < ApplicationController
  # Callbacks
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :set_category,
                only: %i[index],
                if: proc { params[:category_id].present? }
  before_action :set_categories, only: %i[index show]
  before_action :set_form, only: %i[new create edit update]

  # Abilities
  authorize_resource

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

  # GET /blogs/new
  def new
    @form.model.build_picture
    add_breadcrumb t('.title')
  end

  # GET /blogs/1/edit
  def edit
    @form.model.build_picture if @form.picture.nil?
    add_breadcrumb t('.title')
  end

  # POST /blogs
  # POST /blogs.json
  def create
    save_action :new
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    save_action :edit
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    redirect_to blogs_url, notice: t('.notice')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.includes(:user).friendly.find(params[:id])
  end

  def set_category
    @category = Category.friendly.find(params[:category_id])
  end

  def set_categories
    @categories = Category.last(5)
  end

  def set_form
    object = @blog.nil? ? current_user.blogs.new : @blog
    @form = BlogForm.new(object)
  end

  def save_action(action)
    if @form.validate(params[:blog])
      @form.save
      redirect_to category_blog_path(@form.model.category, @form.model), notice: t('.notice')
    else
      render action
    end
  end
end
