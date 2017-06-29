# Categories Creatable
#
RSpec.shared_examples_for :category_creatable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to categories_url }

  it 'creates a record' do
    expect { subject }.to change(Category, :count).by(1)
  end

  describe 'flash message' do
    before { subject }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('categories.create.notice')
    end
  end
end

# Categories Updatable
#
RSpec.shared_examples_for :category_updatable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to categories_url }

  describe 'flash message' do
    before { subject }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('categories.update.notice')
    end
  end

  describe 'values' do
    before { subject }

    it 'changes name' do
      expect(assigns(:category).name).to eq 'FooBar update'
    end
  end
end

# Categories Destroyable
#
RSpec.shared_examples_for :category_destroyable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to categories_url }

  describe 'flash message' do
    before { subject }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('categories.destroy.notice')
    end
  end

  it 'destroys a category' do
    expect { subject }.to change(Category, :count).by(-1)
  end

  it 'destroys associated blogs' do
    expect { subject }.to change(category.blogs, :count).by(-3)
  end
end
