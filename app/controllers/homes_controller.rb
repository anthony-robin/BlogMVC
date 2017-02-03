class HomesController < ApplicationController
  def index
    @title = 'Accueil'
    @blogs = Blog.includes(:category, :user).all.page params[:page]
  end
end
