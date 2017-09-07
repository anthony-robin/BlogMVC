module Admin
  class BlogsController < AdminController
    before_action :set_blog, only: %i[edit update destroy]
    before_action :set_form, only: %i[new create edit update]

    # Abilities
    authorize_resource

    # GET admin/blogs
    def index
      @blogs = Blog.with_includes.order_desc.page params[:page]
    end

    # GET admin/blogs/new
    def new
      @form.model.build_picture
      add_breadcrumb t('.title')
    end

    # POST admin/blogs
    def create
      save_action :new
    end

    # GET /blogs/1/edit
    def edit
      @form.model.build_picture if @form.picture.nil?
      add_breadcrumb t('.title')
    end

    # PATCH/PUT /blogs/1
    def update
      save_action :edit
    end

    # DELETE /blogs/1
    # DELETE /blogs/1.json
    def destroy
      @blog.destroy!
      redirect_to blogs_url, notice: t('.notice')
    end

    private

    def set_blog
      @blog = Blog.includes(:user).friendly.find(params[:id])
    end

    def set_form
      object = @blog.nil? ? current_user.blogs.new : @blog
      @form = BlogForm.new(object)
    end

    def save_action(action)
      if @form.validate(params[:blog]) && @form.save
        redirect_to category_blog_path(@form.model.category, @form.model), notice: t('.notice')
      else
        render action
      end
    end
  end
end
