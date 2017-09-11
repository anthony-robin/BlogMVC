module Users
  class ResetPasswordsController < ApplicationController
    # GET /reset_passwords/new
    def new
    end

    # POST /reset_passwords
    def create
      @user = User.find_by(email: params[:user][:email])

      if @user
        @user.deliver_reset_password_instructions!
        flash[:notice] = t('.reset_password_instructions_sent')
      else
        flash[:alert] = t('.reset_password_instructions_not_sent')
      end

      redirect_to root_path
    end

    # GET /reset_passwords/:id/edit
    # @example /reset_passwords/450eacda8ac77818a/edit
    def edit
      @token = params[:id]
      @user = User.load_from_reset_password_token(@token)

      not_authenticated if @user.blank?
    end

    # PUT /reset_passwords/:id
    # PATCH /reset_passwords/:id
    # @example /reset_passwords/450eacda8ac77818a
    def update
      @token = params[:id]
      @user = User.load_from_reset_password_token(@token)

      return not_authenticated if @user.blank?

      user_params = params[:user]
      if user_params[:password] == user_params[:password_confirmation]
        @user.change_password!(user_params[:password])
        redirect_to root_path, notice: t('.reset_password_updated')
      else
        render :edit
      end
    end
  end
end
