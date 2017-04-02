#
# Comments
# ----------

# Create
shared_examples_for :comment_not_creatable do
  it 'should not create a new comment' do
    expect {
      post :create, params: { blog_id: blog, comment: invalid_params }
    }.to_not change(Comment, :count)
  end
end

# Destroy
shared_examples_for :comment_destroyable do
  it 'should destroy a comment' do
    comment = create(:comment, commentable: blog, user: user)
    expect {
      delete :destroy, params: { blog_id: blog, id: comment }
    }.to change(Comment, :count).by(-1)
  end

  it 'should have correct flash message' do
    expect(flash[:success]).to eq(t('comments.destroy.success'))
  end
end

shared_examples_for :comment_not_destroyable do
  it 'should not destroy a comment' do
    comment = create(:comment, commentable: blog, user: user)
    expect {
      delete :destroy, params: { blog_id: blog, id: comment }
    }.to_not change(Comment, :count)
  end
end
