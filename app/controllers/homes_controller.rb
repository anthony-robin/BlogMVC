class HomesController < ApplicationController
  def index
    @title = 'Accueil'
    @blogs = Blog.includes(:category).all.page params[:page]
  end
end
