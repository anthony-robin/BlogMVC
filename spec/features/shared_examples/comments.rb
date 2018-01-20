RSpec.shared_examples_for :comment_creatable do
  let(:flash_type) { 'success' }
  let(:flash_message) { 'Votre commentaire a été ajouté avec succès' }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }
  it do
    is_expected.to redirect_to category_blog_url(blog.category, blog)
  end

  it 'creates a new comment' do
    expect { subject }.to change { Comment.count }.by(1)
  end

  describe 'owner' do
    before { subject }

    it 'has correct owner' do
      expect(assigns(:comment).user).to eq(user)
    end
  end
end

RSpec.shared_examples_for :comment_not_creatable do
  let(:flash_type) { 'alert' }
  let(:flash_message) { "Votre commentaire n'a pas pu être ajouté" }

  it_behaves_like :flash_message
  it { is_expected.to have_http_status(302) }
  it do
    is_expected.to redirect_to category_blog_url(blog.category, blog)
  end

  it 'does not create a new comment' do
    expect { subject }.to_not change { Comment.count }
  end
end

RSpec.shared_examples_for :comment_destroyable do
  let(:flash_type) { 'success' }
  let(:flash_message) { 'Votre commentaire a bien été supprimé' }

  it_behaves_like :flash_message

  it 'destroys a comment' do
    expect { subject }.to change { Comment.count }.by(-1)
  end
end
