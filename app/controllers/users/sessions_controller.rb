# This controller is responsible to handle a {User user} session
# which means the sign in and sign out actions.
#
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
        params[:user][:password]
      )

      if user
        redirect_back_or_to user_url(user), success: t('.session_created')
      else
        @form = SessionForm.new(@user)
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
