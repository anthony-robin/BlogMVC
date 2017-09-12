module Admin
  class CategoriesController < AdminController
    before_action :set_category, only: %i[edit update destroy]
    before_action :set_form, only: %i[new create edit update]

    authorize_resource
    add_breadcrumb I18n.t('categories.index.title'), :admin_categories_path

    # GET /admin/categories
    def index
      @categories = Category.all.page params[:page]
    end

    # GET /admin/categories/new
    def new
      add_breadcrumb t('.title')
    end

    # GET /admin/categories/1/edit
    def edit
      add_breadcrumb t('.title')
    end

    # POST /admin/categories
    def create
      save_action :new
    end

    # PUT /admin/categories/1
    # PATCH /admin/categories/1
    def update
      save_action :edit
    end

    # DELETE /admin/categories/1
    def destroy
      @category.destroy!
      redirect_to admin_categories_path, notice: t('.notice')
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def set_form
      object = @category.nil? ? Category.new : @category
      @form = CategoryForm.new(object)
    end

    def save_action(action)
      if @form.validate(params[:category]) && @form.save
        redirect_to admin_categories_path, notice: t('.notice')
      else
        render action
      end
    end
  end
end
