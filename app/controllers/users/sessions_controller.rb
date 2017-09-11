module Users
  class SessionsController < ApplicationController
    before_action :require_login, only: %i[destroy]

    load_and_authorize_resource :user, parent: false

    # GET /sessions/new
    def new
      @form = SessionForm.new(@user)
    end

    # POST /sessions
    def create
      user = login(
        params[:user][:email],
        params[:user][:password],
        params[:user][:remember]
      )

      if user
        redirect_to_or_back user_url(user), notice: t('.session_created')
      else
        flash.now.alert = t('.session_not_created')
        render :new
      end
    end

    # DELETE /sessions
    def destroy
      logout
      redirect_to root_url, notice: t('.session_destroyed')
    end
  end
end
