class HomesController < ApplicationController
  def index
    @title = 'Accueil'
    @blogs = Blog.all
  end
end
