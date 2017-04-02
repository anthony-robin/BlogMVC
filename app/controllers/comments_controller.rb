class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_commentable
  before_action :set_comment, only: %i[destroy]

  authorize_resource

  # POST /comments
  # POST /comments.json
  def create
    @comment = @commentable.comment_threads.new(comment_params)
    @comment.user = current_user
    if @comment.save
      flash.now[:success] = t('.success')
      respond_action :create
    else
      flash.now[:alert] = t('.alert')
      respond_action :error
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    if @comment.destroy
      flash.now[:success] = t('.success')
      respond_action :destroy
    else
      flash.now[:alert] = t('.alert')
      respond_action 'comments/forbidden'
    end
  end

  private

  def comment_params
    attributes = %i[title subject body user_id nickname]
    params.require(:comment).permit(attributes)
  end

  def load_commentable
    klass = [Blog].detect { |c| params["#{c.name.underscore}_id"] }
    @commentable = klass.friendly.find(params["#{klass.name.underscore}_id"])
  end

  def set_comment
    @comment = @commentable.comment_threads.find(params[:id])
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
