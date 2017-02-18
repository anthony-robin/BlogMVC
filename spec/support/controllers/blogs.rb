#
# Blogs
# ----------

# Create
shared_examples_for :blog_creatable do
  it { is_expected.to respond_with 302 }
  it 'is expected to redirect to blog url' do
    blog = assigns(:blog)
    expect(response).to redirect_to(category_blog_url(blog.category, blog))
  end
  it { is_expected.to set_flash[:notice].to(t('blogs.create.notice')) }

  it 'should create a record' do
    expect do
      post :create, params: { blog: valid_attributes }
    end.to change(Blog, :count).by(1)
  end
end

# Updatable
shared_examples_for :blog_updatable do
  it { is_expected.to respond_with 302 }
  it 'is expected to redirect to blog url' do
    blog = assigns(:blog)
    expect(response).to redirect_to(category_blog_url(blog.category, blog))
  end
  it { is_expected.to set_flash[:notice].to(t('blogs.update.notice')) }

  it 'expect name to changed' do
    expect(assigns(:blog).title).to eq('FooBar update')
  end
end

# Destroy
shared_examples_for :blog_destroyable do
  it_behaves_like :redirected_request, 'blogs_url'
  it { is_expected.to set_flash[:notice].to(t('blogs.destroy.notice')) }

  it 'should destroy a blog' do
    post :create, params: { blog: valid_attributes }
    expect do
      delete :destroy, params: { id: assigns(:blog) }
    end.to change(Blog, :count).by(-1)
  end
end
