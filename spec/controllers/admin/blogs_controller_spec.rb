require 'rails_helper'

RSpec.describe Admin::BlogsController do
  let(:user) { create(:user) }
  let!(:blog) { create(:blog) }
  let(:category) { create(:category) }
  let(:format) { :html }

  let(:valid_attributes) do
    { blog: { title: Faker::Lorem.sentence,
              content: Faker::Lorem.paragraph,
              category_id: category.id } }
  end

  let(:invalid_attributes) do
    valid_attributes[:blog].merge!(title: '', content: '')
    valid_attributes
  end

  before { login_user user }

  describe 'GET #index' do
    subject { get :index, format: format }

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :index }
  end

  describe 'GET #new' do
    subject { get :new, format: format }

    it_behaves_like :not_logged_in

    context 'when an author' do
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }
    end

    context 'when an admin' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }
    end

    context 'when a master' do
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }
    end
  end

  describe 'POST #create' do
    subject do
      post :create,
        params: { blog: attributes },
        format: format
    end

    let(:attributes) { valid_attributes[:blog] }

    it_behaves_like :not_logged_in

    context 'when an author' do
      let(:user) { create(:user, :author) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :new }
      end

      context 'with valid attributes' do
        it_behaves_like :blog_creatable
      end
    end

    context 'when an admin' do
      let(:user) { create(:user, :admin) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :new }
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:blog] }

        it_behaves_like :blog_creatable
      end
    end

    context 'when a master' do
      let(:user) { create(:user, :master) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :new }
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:blog] }

        it_behaves_like :blog_creatable
      end
    end
  end

  describe 'GET #edit' do
    subject do
      get :edit,
        params: { id: blog, category_id: blog.category },
        format: format
    end

    it_behaves_like :not_logged_in

    context 'when an author' do
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to root_url }
    end

    context 'when an admin' do
      let(:user) { create(:user, :admin) }
      let(:flash_type) { 'alert' }
      let(:flash_message) { "Vous n'êtes pas autorisé à modifier cet article de Blog" }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :edit }

      context 'when try to access a master' do
        let(:blog) { create(:blog, user: create(:user, :master)) }

        it_behaves_like :unauthorized
      end
    end

    context 'when a master' do
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :edit }
    end
  end

  describe 'PATCH #update' do
    subject do
      patch :update,
        params: { id: blog, blog: attributes },
        format: format
    end

    let(:attributes) { valid_attributes[:blog].merge!(title: 'FooBar update') }

    it_behaves_like :not_logged_in

    context 'when an author' do
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to root_url }
    end

    context 'when an admin' do
      let(:user) { create(:user, :admin) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :edit }
      end

      context 'with valid attributes' do
        it_behaves_like :blog_updatable
      end

      context 'when try to access a master' do
        let(:blog) { create(:blog, user: create(:user, :master)) }
        let(:attributes) { blog.category }
        let(:flash_type) { 'alert' }
        let(:flash_message) { "Vous n'êtes pas autorisé à modifier cet article de Blog" }

        it_behaves_like :unauthorized
      end
    end

    context 'when a master' do
      let(:user) { create(:user, :master) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :edit }
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:blog].merge!(title: 'FooBar update') }

        it_behaves_like :blog_updatable
      end
    end
  end

  describe 'DELETE #destroy' do
    subject do
      delete :destroy,
        params: { id: blog },
        format: format
    end

    it_behaves_like :not_logged_in

    context 'when an author' do
      let!(:blog) { create(:blog, :author) }
      let(:user) { blog.user }

      it_behaves_like :blog_destroyable
    end

    context 'when an admin' do
      let(:user) { create(:user, :admin) }

      context 'with its own articles' do
        let(:blog) { create(:blog, user: user) }

        it_behaves_like :blog_destroyable
      end

      context 'when try to access a master' do
        let(:blog) { create(:blog, :master) }
        let(:flash_type) { 'alert' }
        let(:flash_message) { "Vous n'êtes pas autorisé à supprimer cet article de Blog" }

        it_behaves_like :unauthorized
      end
    end

    context 'when a master' do
      let(:user) { create(:user, :master) }
      let(:blog) { create(:blog, user: user) }

      it_behaves_like :blog_destroyable
    end
  end
end
