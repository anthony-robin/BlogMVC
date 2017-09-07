RSpec.shared_examples_for :category_creatable do
  let(:flash_type) { 'notice' }
  let(:flash_message) { 'La Catégorie a été créée avec succès' }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to admin_categories_url }

  it 'creates a record' do
    expect { subject }.to change(Category, :count).by(1)
  end
end

RSpec.shared_examples_for :category_updatable do
  let(:flash_type) { 'notice' }
  let(:flash_message) { 'La Catégorie a été modifiée avec succès' }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to admin_categories_url }

  describe 'values' do
    before { subject }

    it 'changes name' do
      expect(assigns(:category).name).to eq 'FooBar update'
    end
  end
end

RSpec.shared_examples_for :category_destroyable do
  let(:flash_type) { 'notice' }
  let(:flash_message) { 'La Catégorie a été supprimée avec succès' }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to admin_categories_url }

  it 'destroys a category' do
    expect { subject }.to change(Category, :count).by(-1)
  end

  it 'destroys associated blogs' do
    expect { subject }.to change(category.blogs, :count).by(-3)
  end
end
