class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :set_user, only: [:show]

  authorize_resource

  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @blogs = @user.blogs.includes(:category).page params[:page]
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end
