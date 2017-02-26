class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable

  authorize_resource

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comment_threads.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash[:success] = t('.success')
      respond_action :create
    else
      flash[:alert] = t('.alert')
      respond_action :error
    end
  end

  private

  def comment_params
    attributes = %i(title subject body user_id nickname)
    params.require(:comment).permit(attributes)
  end

  def load_commentable
    klass = [Blog].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = klass.friendly.find(params["#{klass.name.underscore}_id"])
  end

  def respond_action(action)
    respond_to do |format|
      format.html do
        redirect_to category_blog_path(@commentable.category, @commentable)
      end
      format.js { render action }
    end
  end
end
