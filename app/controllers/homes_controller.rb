class HomesController < ApplicationController
  def index
    @title = 'Accueil'
    @blogs = Blog.all.page params[:page]
  end
end
