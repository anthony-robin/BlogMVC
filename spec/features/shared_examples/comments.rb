# Comments Creatable
#
RSpec.shared_examples_for :comment_creatable do
  it { is_expected.to have_http_status(302) }
  it do
    is_expected.to redirect_to category_blog_url(blog.category, blog)
  end

  it 'creates a new comment' do
    expect { create_comment }.to change(Comment, :count).by(1)
  end

  describe 'owner' do
    before { create_comment }

    it 'has correct owner' do
      expect(assigns(:comment).user).to eq(user)
    end
  end

  describe 'flash message' do
    before { create_comment }

    it 'has correct message' do
      expect(controller).to set_flash[:success].to(t('comments.create.success'))
    end
  end
end

# Comments not Creatable
#
RSpec.shared_examples_for :comment_not_creatable do
  it { is_expected.to have_http_status(302) }
  it do
    is_expected.to redirect_to category_blog_url(blog.category, blog)
  end

  it 'does not create a new comment' do
    expect { create_comment }.to_not change(Comment, :count)
  end

  describe 'flash message' do
    before { create_comment }

    it 'has correct message' do
      expect(controller).to set_flash[:alert].to(t('comments.create.alert'))
    end
  end
end

# Comments Destroyable
#
RSpec.shared_examples_for :comment_destroyable do
  it 'destroys a comment' do
    expect { destroy_comment }.to change(Comment, :count).by(-1)
  end

  describe 'flash message' do
    before { destroy_comment }

    it 'has correct message' do
      expect(controller).to set_flash[:success].to(t('comments.destroy.success'))
    end
  end
end
