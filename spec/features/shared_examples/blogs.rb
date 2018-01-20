RSpec.shared_examples_for :blog_creatable do
  let(:flash_type) { 'notice' }
  let(:flash_message) { "L'article de Blog a été créé avec succès" }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }

  it do
    is_expected.to redirect_to category_blog_url(assigns(:form).model.category, assigns(:form).model)
  end

  it 'creates a record' do
    expect { subject }.to change { Blog.count }.by(1)
  end

  describe 'owner' do
    before { subject }

    it 'has correct owner' do
      expect(assigns(:form).model.user).to eq(user)
    end
  end
end

RSpec.shared_examples_for :blog_updatable do
  let(:flash_type) { 'notice' }
  let(:flash_message) { "L'article de Blog a été mis à jour avec succès" }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }

  it do
    is_expected.to redirect_to category_blog_url(assigns(:form).model.category, assigns(:form).model)
  end

  describe 'values' do
    before { subject }

    it 'changes name' do
      expect(assigns(:form).model.title).to eq 'FooBar update'
    end
  end
end

RSpec.shared_examples_for :blog_destroyable do
  before do
    create_list :comment, 4,
      commentable: blog,
      user: user
  end

  let(:flash_type) { 'notice' }
  let(:flash_message) { "L'article de Blog a été supprimé avec succès" }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to blogs_url }

  it 'destroys a blog' do
    expect { subject }.to change { Blog.count }.by(-1)
  end

  it 'destroys comments linked' do
    expect { subject }.to change { Comment.count }.by(-4)
  end
end
