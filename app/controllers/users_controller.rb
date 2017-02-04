class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @title = 'Mon profil'
  end
end
