class Blogs::AutocompletesController < ApplicationController
  respond_to :json

  # GET /blogs/autocompletes.json
  def index
    @blogs = Blog.search(params[:query], Blog.search_opts)
    render json: @blogs, each_serializer: Blogs::AutocompleteSerializer
  end
end
