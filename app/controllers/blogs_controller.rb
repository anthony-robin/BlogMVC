class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :set_category,
                only: [:index],
                if: proc { params[:category_id].present? }
  before_action :set_categories, only: [:index, :show]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.includes(:category)
    @blogs = @category.blogs if params[:category_id].present?
    @blogs = @blogs.page params[:page]
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = current_user.blogs.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to category_blog_path(@blog.category, @blog), notice: 'L\'article de Blog a été créé avec succès' }
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
        format.html { redirect_to category_blog_path(@blog.category, @blog), notice: 'L\'article de Blog a été mis à jour avec succès' }
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
      format.html { redirect_to blogs_url, notice: 'L\'article de Blog a été supprimé avec succès' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_blog
    @blog = Blog.friendly.find(params[:id])
  end

  def set_category
    @category = Category.includes(:blogs).friendly.find(params[:category_id])
  end

  def set_categories
    @categories = Category.includes(:blogs).last(5)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def blog_params
    params.require(:blog).permit(:title, :slug, :content, :category_id)
  end
end
