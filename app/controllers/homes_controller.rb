class HomesController < ApplicationController
  def index
    @blogs = Blog.includes(:category, :user).all.page params[:page]
  end
end
