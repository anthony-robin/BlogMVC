class HomesController < ApplicationController
  def index
    @blogs = Blog.includes(:category, :user, :picture).all.page params[:page]
  end
end
