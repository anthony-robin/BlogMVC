# Categories Creatable
#
RSpec.shared_examples_for :category_creatable do
  it_behaves_like :redirected_request, 'categories_url'

  it 'has correct flash message' do
    expect(controller).to set_flash[:notice].to(t('categories.create.notice'))
  end

  it 'creates a record' do
    expect do
      post :create, params: { category: attributes.merge!(name: Faker::Lorem.sentence) }
    end.to change(Category, :count).by(1)
  end
end

# Categories Updatable
#
RSpec.shared_examples_for :category_updatable do
  it_behaves_like :redirected_request, 'categories_url'

  it 'has correct flash message' do
    expect(controller).to set_flash[:notice].to(t('categories.update.notice'))
  end

  it 'changes name' do
    expect(assigns(:category).name).to eq('FooBar update')
  end
end

# Categories Destroyable
#
RSpec.shared_examples_for :category_destroyable do
  it_behaves_like :redirected_request, 'categories_url'

  it 'has correct flash message' do
    expect(controller).to set_flash[:notice].to(t('categories.destroy.notice'))
  end

  it 'destroys a category (and blogs)' do
    category = create(:category)
    create_list(:blog, 3, category: category)
    expect do
      delete :destroy, params: { id: category }
    end.to change(Category, :count).by(-1).and \
           change(category.blogs, :count).by(-3)
  end
end
