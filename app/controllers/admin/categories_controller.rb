module Admin
  class CategoriesController < AdminController
    load_and_authorize_resource

    before_action :set_form,
      only: %i[new create edit update]

    add_breadcrumb I18n.t('categories.index.title'), :admin_categories_path

    # GET /admin/categories
    def index
      @categories = @categories.page params[:page]
    end

    # GET /admin/categories/new
    def new
      add_breadcrumb t('.title')
    end

    # GET /admin/categories/:id/edit
    def edit
      add_breadcrumb t('.title')
    end

    # POST /admin/categories
    def create
      save_action :new
    end

    # PUT /admin/categories/:id
    # PATCH /admin/categories/:id
    def update
      save_action :edit
    end

    # DELETE /admin/categories/:id
    def destroy
      @category.destroy!
      redirect_to admin_categories_path, notice: t('.notice')
    end

    private

    def set_form
      @form = CategoryForm.new(@category || Category.new)
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
