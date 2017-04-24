class BlogsController < ApplicationController
  # Callbacks
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_blog, only: %i[show edit update destroy]
  before_action :set_category,
                only: %i[index],
                if: proc { params[:category_id].present? }
  before_action :set_categories, only: %i[index show]

  # Abilities
  authorize_resource

  # GET /blogs
  # GET /blogs.json
  def index
    search = params[:term].present? ? params[:term] : nil
    return @blogs = Blog.search(search, Blog.search_opts) if search

    @blogs = Blog.with_includes.order_desc
    @blogs = @category.blogs.includes(:user, :category) if params[:category_id].present?
    @blogs = @blogs.tagged_with(params[:tag]) if params[:tag]
    @blogs = @blogs.page params[:page]
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    @commentable = @blog
    @comment = Comment.new
    @comments = @commentable.comment_threads.includes(:user, :commentable).order(created_at: :desc)
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
    @blog.build_picture
  end

  # GET /blogs/1/edit
  def edit
    @blog.build_picture if @blog.picture.nil?
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to category_blog_path(@blog.category, @blog), notice: t('.notice') }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to category_blog_path(@blog.category, @blog), notice: t('.notice') }
        format.js { render nothing: true }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: t('.notice') }
    end
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

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(:title, :slug, :content, :category_id, :tag_list, picture_attributes: %i[id image image_cache _destroy])
  end
end
