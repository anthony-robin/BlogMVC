require 'rails_helper'

RSpec.describe Admin::CategoriesController do
  let(:user) { create(:user) }
  let!(:category) { create(:category) }
  let(:format) { :html }

  let(:valid_attributes) { { category: { name: 'FooBar' } } }
  let(:invalid_attributes) do
    valid_attributes[:category].merge!(name: '')
    valid_attributes
  end

  before { login_user user }

  describe 'GET #index' do
    subject { get :index, format: format }

    context 'when not logged in' do
      it_behaves_like :not_logged_in
    end

    context 'as author' do
      let(:user) { create(:user, :author) }

      it_behaves_like :unauthorized, I18n.t('unauthorized.read.category')
    end

    context 'as admin' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :index }
    end

    context 'as master' do
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :index }
    end
  end

  describe 'GET #new' do
    subject { get :new, format: format }

    context 'when not logged in' do
      it_behaves_like :not_logged_in
    end

    context 'as author' do
      let(:user) { create(:user, :author) }

      it_behaves_like :unauthorized, I18n.t('unauthorized.manage.all')
    end

    context 'as admin' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }
    end

    context 'as master' do
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }
    end
  end

  describe 'POST #create' do
    subject(:create_category) do
      post :create,
        params: { category: attributes },
        format: format
    end

    let(:attributes) { valid_attributes }

    context 'when not logged in' do
      it_behaves_like :not_logged_in

      it_behaves_like :unauthorized, I18n.t('unauthorized.manage.all')

      it 'does not create a record' do
        expect { create_category }.to_not change(Category, :count)
      end
    end

    context 'as author' do
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to root_url }

      it 'does not create a record' do
        expect { create_category }.to_not change(Category, :count)
      end
    end

    context 'as admin' do
      let(:user) { create(:user, :admin) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :new }
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:category] }

        it_behaves_like :category_creatable
      end
    end

    context 'as master' do
      let(:user) { create(:user, :master) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :new }
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:category] }

        it_behaves_like :category_creatable
      end
    end
  end

  describe 'GET #edit' do
    subject do
      get :edit,
        params: { id: category },
        format: format
    end

    context 'when not logged in' do
      it_behaves_like :not_logged_in
    end

    context 'as author' do
      let(:user) { create(:user, :author) }

      it_behaves_like :unauthorized, I18n.t('unauthorized.manage.all')
    end

    context 'as admin' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :edit }
    end

    context 'as master' do
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :edit }
    end
  end

  describe 'PATCH #update' do
    subject(:update_category) do
      patch :update,
        params: { id: category, category: attributes },
        format: format
    end

    let(:attributes) { valid_attributes[:category].merge!(name: 'FooBar update') }

    context 'when not logged in' do
      it_behaves_like :not_logged_in
    end

    context 'as author' do
      let(:user) { create(:user, :author) }

      it_behaves_like :unauthorized, I18n.t('unauthorized.manage.all')
    end

    context 'as admin' do
      let(:user) { create(:user, :admin) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :edit }
      end

      context 'with valid attributes' do
        it_behaves_like :category_updatable
      end
    end

    context 'as master' do
      let(:user) { create(:user, :master) }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }

        it { is_expected.to have_http_status(200) }
        it { is_expected.to render_template :edit }
      end

      context 'with valid attributes' do
        it_behaves_like :category_updatable
      end
    end
  end

  describe 'DELETE #destroy' do
    before { create_list(:blog, 3, category: category) }

    subject(:destroy_category) do
      delete :destroy,
        params: { id: category },
        format: format
    end

    context 'when not logged in' do
      it_behaves_like :not_logged_in
    end

    context 'as author' do
      let(:user) { create(:user, :author) }

      it_behaves_like :unauthorized, I18n.t('unauthorized.manage.all')

      it 'does not destroy a category' do
        expect { destroy_category }.to_not change(Category, :count)
      end

      it 'does not destroy associated blogs' do
        expect { destroy_category }.to_not change(category.blogs, :count)
      end
    end

    context 'as admin' do
      let(:user) { create(:user, :admin) }

      it_behaves_like :category_destroyable
    end

    context 'as master' do
      let(:user) { create(:user, :master) }

      it_behaves_like :category_destroyable
    end
  end
end
