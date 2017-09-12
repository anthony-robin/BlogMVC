class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_user, only: [:show]

  authorize_resource

  # GET /users
  def index
    add_breadcrumb t('.title', profile: current_user.username)
  end

  # GET /users/1
  def show
    @blogs = @user.blogs.includes(:category).page params[:page]
    add_breadcrumb t('.title', profile: @user.username)
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
