require 'rails_helper'

describe CategoriesController do
  let(:category) { create(:category) }
  let(:valid_attributes) { { name: 'FooBar' } }
  let(:valid_attributes_2) { { name: 'BarFoo' } }
  let(:invalid_attributes) { { name: '' } }

  describe 'GET #index' do
    context 'a non connected user' do
      before { get :index }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { get :index }
        it { is_expected.to set_flash[:alert].to(t('unauthorized.read.category')) }
        it_behaves_like :redirected_request, 'root_url'
      end

      context 'as admin' do
        login_user(:admin)
        before { get :index }
        it_behaves_like :ok_request, 'index'
      end

      context 'as master' do
        login_user(:master)
        before { get :index }
        it_behaves_like :ok_request, 'index'
      end
    end
  end

  describe 'GET #new' do
    context 'a non connected user' do
      before { get :new }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { get :new }
        it_behaves_like :redirected_request, 'root_url'
      end

      context 'as admin' do
        login_user(:admin)
        before { get :new }
        it_behaves_like :ok_request, 'new'
      end

      context 'as master' do
        login_user(:master)
        before { get :new }
        it_behaves_like :ok_request, 'new'
      end
    end
  end

  describe 'POST #create' do
    context 'a non connected user' do
      before { post :create, params: { category: valid_attributes } }
      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'should not create a record' do
        expect do
          post :create, params: { category: valid_attributes_2 }
        end.to_not change(Category, :count)
      end
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { post :create, params: { category: valid_attributes } }
        it_behaves_like :redirected_request, 'root_url'

        it 'should not create a record' do
          expect do
            post :create, params: { category: valid_attributes_2 }
          end.to_not change(Category, :count)
        end
      end

      context 'as admin' do
        login_user(:admin)
        context 'with invalid attributes' do
          before { post :create, params: { category: invalid_attributes } }
          it_behaves_like :ok_request, 'new'
        end

        context 'with valid attributes' do
          before { post :create, params: { category: valid_attributes } }
          it_behaves_like :category_creatable
        end
      end

      context 'as master' do
        login_user(:master)
        context 'with invalid attributes' do
          before { post :create, params: { category: invalid_attributes } }
          it_behaves_like :ok_request, 'new'
        end

        context 'with valid attributes' do
          before { post :create, params: { category: valid_attributes } }
          it_behaves_like :category_creatable
        end
      end
    end
  end

  describe 'GET #edit' do
    context 'a non connected user' do
      before { get :edit, params: { id: category } }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { get :edit, params: { id: category } }
        it_behaves_like :redirected_request, 'root_url'
      end

      context 'as admin' do
        login_user(:admin)
        before { get :edit, params: { id: category } }
        it_behaves_like :ok_request, 'edit'
      end

      context 'as master' do
        login_user(:master)
        before { get :edit, params: { id: category } }
        it_behaves_like :ok_request, 'edit'
      end
    end
  end

  describe 'PATCH #update' do
    let(:updated_attributes) { { name: 'FooBar update' } }

    context 'a non connected user' do
      before { patch :update, params: { id: category, category: updated_attributes } }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { patch :update, params: { id: category, category: updated_attributes } }
        it_behaves_like :redirected_request, 'root_url'
      end

      context 'as admin' do
        login_user(:admin)
        context 'with invalid attributes' do
          before { patch :update, params: { id: category, category: invalid_attributes } }
          it_behaves_like :ok_request, 'edit'
        end

        context 'with valid attributes' do
          before { patch :update, params: { id: category, category: updated_attributes } }
          it_behaves_like :category_updatable
        end
      end

      context 'as master' do
        login_user(:master)
        context 'with invalid attributes' do
          before { patch :update, params: { id: category, category: invalid_attributes } }
          it_behaves_like :ok_request, 'edit'
        end

        context 'with valid attributes' do
          before { patch :update, params: { id: category, category: updated_attributes } }
          it_behaves_like :category_updatable
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before { create_list(:blog, 3, category: category) }

    context 'a non connected user' do
      before { delete :destroy, params: { id: category } }
      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'should not destroy a category (and blogs)' do
        expect do
          delete :destroy, params: { id: category }
        end.to change(Category, :count).by(0).and \
               change(category.blogs, :count).by(0)
      end
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { delete :destroy, params: { id: category } }
        it_behaves_like :redirected_request, 'root_url'

        it 'should not destroy a category (and blogs)' do
          expect do
            delete :destroy, params: { id: category }
          end.to change(Category, :count).by(0).and \
                 change(category.blogs, :count).by(0)
        end
      end

      context 'as admin' do
        login_user(:admin)
        before { delete :destroy, params: { id: category } }
        it_behaves_like :category_destroyable
      end

      context 'as master' do
        login_user(:master)
        before { delete :destroy, params: { id: category } }
        it_behaves_like :category_destroyable
      end
    end
  end
end
