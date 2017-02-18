require 'rails_helper'

describe BlogsController do
  let!(:blog) { create(:blog) }
  let(:category) { create(:category) }
  let(:valid_attributes) { { title: 'Foo', content: '<p>Lorem ipsum</p>', category_id: category.id } }
  let(:invalid_attributes) { { title: '', content: '', category_id: category.id } }

  describe 'GET #index' do
    context 'everyone' do
      before { get :index }
      it_behaves_like :ok_request, 'index'
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
        it_behaves_like :ok_request, 'new'
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
      before { post :create, params: { blog: valid_attributes } }
      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'should not create a record' do
        expect do
          post :create, params: { blog: valid_attributes }
        end.to_not change(Blog, :count)
      end
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        context 'with invalid attributes' do
          before { post :create, params: { blog: invalid_attributes } }
          it_behaves_like :ok_request, 'new'
        end

        context 'with valid attributes' do
          before { post :create, params: { blog: valid_attributes } }
          it_behaves_like :blog_creatable
          it('should have correct owner') { expect(assigns(:blog).user).to eq(@author) }
        end
      end

      context 'as admin' do
        login_user(:admin)
        context 'with invalid attributes' do
          before { post :create, params: { blog: invalid_attributes } }
          it_behaves_like :ok_request, 'new'
        end

        context 'with valid attributes' do
          before { post :create, params: { blog: valid_attributes } }
          it_behaves_like :blog_creatable
          it('should have correct owner') { expect(assigns(:blog).user).to eq(@admin) }
        end
      end

      context 'as master' do
        login_user(:master)
        context 'with invalid attributes' do
          before { post :create, params: { blog: invalid_attributes } }
          it_behaves_like :ok_request, 'new'
        end

        context 'with valid attributes' do
          before { post :create, params: { blog: valid_attributes } }
          it_behaves_like :blog_creatable
          it('should have correct owner') { expect(assigns(:blog).user).to eq(@master) }
        end
      end
    end
  end

  describe 'GET #show' do
    context 'everyone' do
      before { get :show, params: { id: blog, category_id: blog.category } }
      it_behaves_like :ok_request, 'show'
    end
  end

  describe 'GET #edit' do
    context 'a non connected user' do
      before { get :edit, params: { id: blog, category_id: blog.category } }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { get :edit, params: { id: blog, category_id: blog.category } }
        it_behaves_like :redirected_request, 'root_url'
      end

      context 'as admin' do
        login_user(:admin)
        before { get :edit, params: { id: blog, category_id: blog.category } }
        it_behaves_like :ok_request, 'edit'

        context 'when try to access a master' do
          let(:blog) { create(:blog, user: create(:user, :master)) }
          before { get :edit, params: { id: blog, category_id: blog.category } }
          it_behaves_like :cancan_unauthorized_request, 'root_url', 'unauthorized.update.blog'
        end
      end

      context 'as master' do
        login_user(:master)
        before { get :edit, params: { id: blog, category_id: blog.category } }
        it_behaves_like :ok_request, 'edit'
      end
    end
  end

  describe 'PATCH #update' do
    let(:updated_attributes) { { title: 'FooBar update' } }

    context 'a non connected user' do
      before { patch :update, params: { id: blog, blog: updated_attributes } }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { patch :update, params: { id: blog, blog: updated_attributes } }
        it_behaves_like :redirected_request, 'root_url'
      end

      context 'as admin' do
        login_user(:admin)
        context 'with invalid attributes' do
          before { patch :update, params: { id: blog, blog: invalid_attributes } }
          it_behaves_like :ok_request, 'edit'
        end

        context 'with valid attributes' do
          before { patch :update, params: { id: blog, blog: updated_attributes } }
          it_behaves_like :blog_updatable
        end

        context 'when try to access a master' do
          let(:blog) { create(:blog, user: create(:user, :master)) }
          before { patch :update, params: { id: blog, blog: blog.category } }
          it_behaves_like :cancan_unauthorized_request, 'root_url', 'unauthorized.update.blog'
        end
      end

      context 'as master' do
        login_user(:master)
        context 'with invalid attributes' do
          before { patch :update, params: { id: blog, blog: invalid_attributes } }
          it_behaves_like :ok_request, 'edit'
        end

        context 'with valid attributes' do
          before { patch :update, params: { id: blog, blog: updated_attributes } }
          it_behaves_like :blog_updatable
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before { create_list(:blog, 3, category: category) }

    context 'a non connected user' do
      before { delete :destroy, params: { id: blog } }
      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'should not destroy a blog article' do
        expect do
          delete :destroy, params: { id: blog }
        end.to change(Blog, :count).by(0)
      end
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before do
          blog = create(:blog, user: @author)
          delete :destroy, params: { id: blog }
        end
        it_behaves_like :blog_destroyable
      end

      context 'as admin' do
        login_user(:admin)
        before do
          blog = create(:blog, user: @admin)
          delete :destroy, params: { id: blog }
        end
        it_behaves_like :blog_destroyable

        context 'when try to access a master' do
          let(:blog) { create(:blog, user: create(:user, :master)) }
          before { delete :destroy, params: { id: blog } }
          it_behaves_like :cancan_unauthorized_request, 'root_url', 'unauthorized.destroy.blog'
        end
      end

      context 'as master' do
        login_user(:master)
        before do
          blog = create(:blog, user: @master)
          delete :destroy, params: { id: blog }
        end
        it_behaves_like :blog_destroyable
      end
    end
  end
end
