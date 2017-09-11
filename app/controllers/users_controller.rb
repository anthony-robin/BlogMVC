class UsersController < ApplicationController
  before_action :require_login, except: %i[new create show]

  load_and_authorize_resource

  # GET /users
  def index
    add_breadcrumb t('.title', profile: current_user.username)
  end

  # GET /users/new
  def new
    if logged_in?
      redirect_to user_url(current_user), alert: t('.already_logged_in')
    else
      @form = UserForm.new(@user)
    end
  end

  # POST /users
  def create
    @form = UserForm.new(@user)
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
  end

  # DELETE /users/:id
  def destroy
    logout
    @user.destroy!
    redirect_to root_url, notice: t('.user_destroyed')
  end
end
