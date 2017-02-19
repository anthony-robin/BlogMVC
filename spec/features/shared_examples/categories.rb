#
# Categories
# ----------

# Create
shared_examples_for :category_creatable do
  it_behaves_like :redirected_request, 'categories_url'
  it { is_expected.to set_flash[:notice].to(t('categories.create.notice')) }

  it 'should create a record' do
    expect do
      post :create, params: { category: valid_attributes_2 }
    end.to change(Category, :count).by(1)
  end
end

# Updatable
shared_examples_for :category_updatable do
  it_behaves_like :redirected_request, 'categories_url'
  it { is_expected.to set_flash[:notice].to(t('categories.update.notice')) }

  it 'expect name to changed' do
    expect(assigns(:category).name).to eq('FooBar update')
  end
end

# Destroy
shared_examples_for :category_destroyable do
  it_behaves_like :redirected_request, 'categories_url'
  it { is_expected.to set_flash[:notice].to(t('categories.destroy.notice')) }

  it 'should destroy a category (and blogs)' do
    category = create(:category)
    create_list(:blog, 3, category: category)
    expect do
      delete :destroy, params: { id: category }
    end.to change(Category, :count).by(-1).and \
           change(category.blogs, :count).by(-3)
  end
end
