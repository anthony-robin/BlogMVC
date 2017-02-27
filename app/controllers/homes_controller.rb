class HomesController < ApplicationController
  before_action :set_blogs_carousel, only: %i(index)

  def index
    @blogs = Blog.includes(:category, :user, :picture).order_desc.all.page params[:page]
  end

  private

  def set_blogs_carousel
    @blogs_carousel = Blog.includes(:user).order_desc.first(5)
  end
end
