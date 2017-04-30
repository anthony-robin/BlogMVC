# Blogs Creatable
#
shared_examples_for :blog_creatable do
  it { is_expected.to have_http_status(302) }

  it 'has correct flash message' do
    expect(controller).to set_flash[:notice].to(t('blogs.create.notice'))
  end

  it 'has correct owner' do
    model = assigns(:form).model
    expect(model.user).to eq(@user)
  end

  it 'redirects to blog url' do
    blog = assigns(:form).model
    expect(response).to redirect_to(category_blog_url(blog.category, blog))
  end

  it 'creates a record' do
    expect { post :create, params: { blog: attributes } }.to change(Blog, :count).by(1)
  end
end

# Blogs Updatable
#
shared_examples_for :blog_updatable do
  it { is_expected.to have_http_status(302) }

  it 'has correct flash message' do
    expect(controller).to set_flash[:notice].to(t('blogs.update.notice'))
  end

  it 'redirects to blog url' do
    model = assigns(:form).model
    expect(response).to redirect_to(category_blog_url(model.category, model))
  end

  it 'changes name' do
    model = assigns(:form).model
    expect(model.title).to eq('FooBar update')
  end
end

# Blogs Destroyable
#
shared_examples_for :blog_destroyable do
  it_behaves_like :redirected_request, 'blogs_url'

  it 'has correct flash message' do
    expect(controller).to set_flash[:notice].to(t('blogs.destroy.notice'))
  end

  it 'destroys a blog' do
    blog2 = create(:blog, user: blog.user)

    expect do
      delete :destroy, params: { id: blog2 }
    end.to change(Blog, :count).by(-1)
  end
end
