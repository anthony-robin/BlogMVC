# Comments Creatable
#
shared_examples_for :comment_creatable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to(category_blog_url(blog.category, blog)) }

  it 'creates a new comment' do
    expect {
      post :create, params: { blog_id: blog, comment: valid_params[:comment] }
    }.to change(Comment, :count).by(1)
  end

  it 'has correct flash success' do
    expect(controller).to set_flash[:success].to(t('comments.create.success'))
  end
end

# Comments not Creatable
#
shared_examples_for :comment_not_creatable do
  it 'does not create a new comment' do
    expect {
      post :create, params: { blog_id: blog, comment: invalid_params[:comment] }
    }.to_not change(Comment, :count)
  end
end

# Comments Destroyable
#
shared_examples_for :comment_destroyable do
  it 'destroys a comment' do
    comment = create(:comment, commentable: blog, user: user)
    expect {
      delete :destroy, params: { blog_id: blog, id: comment }
    }.to change(Comment, :count).by(-1)
  end

  it 'has correct flash message' do
    expect(controller).to set_flash[:success].to(t('comments.destroy.success'))
  end
end

# Comments not Destroyable
#
shared_examples_for :comment_not_destroyable do
  it 'does not destroy a comment' do
    comment = create(:comment, commentable: blog, user: user)
    expect {
      delete :destroy, params: { blog_id: blog, id: comment }
    }.to_not change(Comment, :count)
  end
end
