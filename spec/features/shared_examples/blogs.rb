# Blogs Creatable
#
RSpec.shared_examples_for :blog_creatable do
  it { is_expected.to have_http_status(302) }

  it do
    is_expected.to redirect_to category_blog_url(assigns(:form).model.category, assigns(:form).model)
  end

  it 'creates a record' do
    expect { subject }.to change(Blog, :count).by(1)
  end

  describe 'owner' do
    before { subject }

    it 'has correct owner' do
      expect(assigns(:form).model.user).to eq(user)
    end
  end

  describe 'flash message' do
    before { subject }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('blogs.create.notice')
    end
  end
end

# Blogs Updatable
#
RSpec.shared_examples_for :blog_updatable do
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

  describe 'flash message' do
    before { subject }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('blogs.update.notice')
    end
  end
end

# Blogs Destroyable
#
RSpec.shared_examples_for :blog_destroyable do
  it { is_expected.to have_http_status(302) }
  it { is_expected.to redirect_to blogs_url }

  it 'destroys a blog' do
    expect { subject }.to change(Blog, :count).by(-1)
  end

  describe 'flash message' do
    before { subject }

    it 'has correct message' do
      expect(controller).to set_flash[:notice].to t('blogs.destroy.notice')
    end
  end
end
