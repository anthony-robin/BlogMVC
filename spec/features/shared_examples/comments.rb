#
# Comments
# ----------

shared_examples_for :comment_not_creatable do
  it 'should not create a new comment' do
    expect {
      post :create, params: { blog_id: blog, comment: invalid_params }
    }.to_not change(Comment, :count)
  end
end
