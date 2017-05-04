require 'rails_helper'

describe CategoriesController do
  let(:category) { create(:category) }

  let(:valid_attributes) { { category: { name: 'FooBar' } } }
  let(:invalid_attributes) do
    valid_attributes[:category].merge!(name: '')
    valid_attributes
  end

  describe 'GET #index' do
    context 'a non connected user' do
      subject! { get :index }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'an author' do
      login_user(:author)
      subject! { get :index }

      it_behaves_like :cancan_unauthorized_request, 'root_url', 'unauthorized.read.category'
    end

    context 'an admin' do
      login_user(:admin)
      subject! { get :index }

      it_behaves_like :ok_request, 'index'
    end

    context 'a master' do
      login_user(:master)
      subject! { get :index }

      it_behaves_like :ok_request, 'index'
    end
  end

  describe 'GET #new' do
    context 'a non connected user' do
      subject! { get :new }

      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'an author' do
      login_user(:author)
      subject! { get :new }

      it_behaves_like :redirected_request, 'root_url'
    end

    context 'an admin' do
      login_user(:admin)
      subject! { get :new }

      it_behaves_like :ok_request, 'new'
    end

    context 'a master' do
      login_user(:master)
      subject! { get :new }

      it_behaves_like :ok_request, 'new'
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { category: attributes } }

    context 'a non connected user' do
      let(:attributes) { valid_attributes[:category] }
      before { subject }

      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'should not create a record' do
        expect do
          post :create, params: { category: valid_attributes[:category].merge!(name: 'BarFoo') }
        end.to_not change(Category, :count)
      end
    end

    context 'an author' do
      let(:attributes) { valid_attributes }
      login_user(:author)
      before { subject }

      it_behaves_like :redirected_request, 'root_url'

      it 'should not create a record' do
        expect do
          post :create, params: { category: valid_attributes[:category].merge!(name: 'BarFoo') }
        end.to_not change(Category, :count)
      end
    end

    context 'an admin' do
      login_user(:admin)

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }
        before { subject }

        it_behaves_like :ok_request, 'new'
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:category] }
        before { subject }

        it_behaves_like :category_creatable
      end
    end

    context 'a master' do
      login_user(:master)

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }
        before { subject }

        it_behaves_like :ok_request, 'new'
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:category] }
        before { subject }

        it_behaves_like :category_creatable
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: category } }

    context 'a non connected user' do
      before { subject }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'an author' do
      login_user(:author)
      before { subject }

      it_behaves_like :redirected_request, 'root_url'
    end

    context 'an admin' do
      login_user(:admin)
      before { subject }

      it_behaves_like :ok_request, 'edit'
    end

    context 'a master' do
      login_user(:master)
      before { subject }

      it_behaves_like :ok_request, 'edit'
    end
  end

  describe 'PATCH #update' do
    let(:attributes) { valid_attributes[:category].merge!(name: 'FooBar update') }
    subject { patch :update, params: { id: category, category: attributes } }

    context 'a non connected user' do
      before { subject }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'an author' do
      login_user(:author)
      before { subject }

      it_behaves_like :redirected_request, 'root_url'
    end

    context 'an admin' do
      login_user(:admin)

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }
        before { subject }

        it_behaves_like :ok_request, 'edit'
      end

      context 'with valid attributes' do
        before { subject }
        it_behaves_like :category_updatable
      end
    end

    context 'a master' do
      login_user(:master)

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:category] }
        before { subject }

        it_behaves_like :ok_request, 'edit'
      end

      context 'with valid attributes' do
        before { subject }
        it_behaves_like :category_updatable
      end
    end
  end

  describe 'DELETE #destroy' do
    before { create_list(:blog, 3, category: category) }
    subject { delete :destroy, params: { id: category } }

    context 'a non connected user' do
      before { subject }
      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'should not destroy a category (and blogs)' do
        expect do
          delete :destroy, params: { id: category }
        end.to change(Category, :count).by(0).and \
               change(category.blogs, :count).by(0)
      end
    end

    context 'an author' do
      login_user(:author)
      before { subject }

      it_behaves_like :redirected_request, 'root_url'

      it 'should not destroy a category (and blogs)' do
        expect do
          delete :destroy, params: { id: category }
        end.to change(Category, :count).by(0).and \
               change(category.blogs, :count).by(0)
      end
    end

    context 'an admin' do
      login_user(:admin)
      before { subject }

      it_behaves_like :category_destroyable
    end

    context 'a master' do
      login_user(:master)
      before { subject }

      it_behaves_like :category_destroyable
    end
  end
end
