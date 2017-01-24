class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @title = 'Liste des catégories'
    @categories = Category.all.page params[:page]
  end

  # GET /categories/new
  def new
    @title = 'Ajouter une catégorie'
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @title = 'Modifier une catégorie'
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'La Catégorie a été créée avec succès.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'La Catégorie a été modifiée avec succès' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'La Categorie a été supprimée avec succès.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :slug)
    end
end
