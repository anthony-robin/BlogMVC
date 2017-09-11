module Blogs
  class AutocompletesController < ApplicationController
    # GET /blogs/autocompletes.json
    # @example /blogs/autocompletes.json?query=paris
    def index
      @blogs = Blog.search(params[:query], Blog.search_opts)
      render json: @blogs, each_serializer: Blogs::AutocompleteSerializer
    end
  end
end
