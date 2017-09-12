class HomesController < ApplicationController
  load_resource :blog, parent: false

  # GET /
  def index
    @blogs = @blogs.includes(:user).order_desc.first(5)
  end
end
