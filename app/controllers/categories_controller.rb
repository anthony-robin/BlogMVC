class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[edit update destroy]
  before_action :set_form, only: %i[new create edit update]

  # Abilities
  authorize_resource

  # Breadcrumbs
  add_breadcrumb I18n.t('categories.index.title'), :categories_path

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all.page params[:page]
  end

  # GET /categories/new
  def new
    add_breadcrumb t('.title')
  end

  # GET /categories/1/edit
  def edit
    add_breadcrumb t('.title')
  end

  # POST /categories
  # POST /categories.json
  def create
    save_action :new
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    save_action :edit
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    redirect_to categories_url, notice: t('.notice')
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
    if @form.validate(params[:category])
      @form.save
      redirect_to categories_path, notice: t('.notice')
    else
      render action
    end
  end
end
