# This controller is responsible to handle the creation (sign up action),
# the modification and the destruction of a {User user} account.
#
class UsersController < ApplicationController
  before_action :require_login, except: %i[new create show]
  load_and_authorize_resource
  before_action :set_form, only: %i[new create edit update]

  # GET /users
  def index
    add_breadcrumb t('.title', profile: current_user.username)
  end

  # GET /users/new
  def new
    redirect_to user_url(current_user), alert: t('.already_logged_in') if logged_in?
  end

  # POST /users
  def create
    if @form.validate(params[:user]) && @form.save
      auto_login(@user)
      redirect_to user_path(@form.model), notice: t('.user_created')
    else
      render :new
    end
  end

  # GET /users/:id
  def show
    @blogs = @user.blogs.includes(:category).page params[:page]
    add_breadcrumb t('.title', profile: @user.username)
  end

  # GET /users/:id/edit
  def edit
  end

  # PUT /users/:id
  # PATCH /users/:id
  def update
    if @form.validate(params[:user]) && @form.save
      redirect_to user_path(@form.model), notice: t('.user_updated')
    else
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    logout
    @user.destroy!
    redirect_to root_url, notice: t('.user_destroyed')
  end

  private

  def set_form
    @form = UserForm.new(@user)
  end
end
