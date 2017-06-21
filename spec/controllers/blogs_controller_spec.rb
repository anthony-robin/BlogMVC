require 'rails_helper'

RSpec.describe BlogsController do
  let!(:blog) { create(:blog) }
  let(:category) { create(:category) }

  let(:valid_attributes) do
    { blog: { title: Faker::Lorem.sentence,
              content: Faker::Lorem.paragraph,
              category_id: category.id } }
  end

  let(:invalid_attributes) do
    valid_attributes[:blog].merge!(title: '', content: '')
    valid_attributes
  end

  describe 'GET #index' do
    subject! { get :index }
    it_behaves_like :ok_request, 'index'
  end

  describe 'GET #new' do
    subject { get :new }

    context 'a non connected user' do
      before { subject }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'an author' do
      login_user(:author)
      before { subject }

      it_behaves_like :ok_request, 'new'
    end

    context 'an admin' do
      login_user(:admin)
      before { subject }

      it_behaves_like :ok_request, 'new'
    end

    context 'a master' do
      login_user(:master)
      before { subject }

      it_behaves_like :ok_request, 'new'
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { blog: attributes } }

    context 'a non connected user' do
      let(:attributes) { valid_attributes[:blog] }
      before { subject }

      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'does not create a record' do
        expect { subject }.to_not change(Blog, :count)
      end
    end

    context 'an author' do
      login_user(:author)
      before { subject }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }
        it_behaves_like :ok_request, 'new'
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:blog] }
        it_behaves_like :blog_creatable
      end
    end

    context 'an admin' do
      login_user(:admin)
      before { subject }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }
        it_behaves_like :ok_request, 'new'
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:blog] }

        it_behaves_like :blog_creatable
        it('has correct owner') { expect(assigns(:form).model.user).to eq(@admin) }
      end
    end

    context 'a master' do
      login_user(:master)
      before { subject }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }
        it_behaves_like :ok_request, 'new'
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:blog] }

        it_behaves_like :blog_creatable
        it('has correct owner') { expect(assigns(:form).model.user).to eq(@master) }
      end
    end
  end

  describe 'GET #show' do
    subject { get :show, params: { id: blog, category_id: blog.category } }
    before { subject }

    it_behaves_like :ok_request, 'show'
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: blog, category_id: blog.category } }

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

      context 'when try to access a master' do
        let(:blog) { create(:blog, user: create(:user, :master)) }
        before { subject }
        it_behaves_like :cancan_unauthorized_request, 'root_url', 'unauthorized.update.blog'
      end
    end

    context 'a master' do
      login_user(:master)
      before { subject }

      it_behaves_like :ok_request, 'edit'
    end
  end

  describe 'PATCH #update' do
    let(:attributes) { valid_attributes[:blog].merge!(title: 'FooBar update') }
    subject { patch :update, params: { id: blog, blog: attributes } }

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

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }
        it_behaves_like :ok_request, 'edit'
      end

      context 'with valid attributes' do
        it_behaves_like :blog_updatable
      end

      context 'when try to access a master' do
        let(:blog) { create(:blog, user: create(:user, :master)) }
        let(:attributes) { blog.category }

        it_behaves_like :cancan_unauthorized_request, 'root_url', 'unauthorized.update.blog'
      end
    end

    context 'a master' do
      login_user(:master)
      before { subject }

      context 'with invalid attributes' do
        let(:attributes) { invalid_attributes[:blog] }
        it_behaves_like :ok_request, 'edit'
      end

      context 'with valid attributes' do
        let(:attributes) { valid_attributes[:blog].merge!(title: 'FooBar update') }

        it_behaves_like :blog_updatable
      end
    end
  end

  describe 'DELETE #destroy' do
    before { create_list(:blog, 3, category: category) }
    subject { delete :destroy, params: { id: blog } }

    context 'a non connected user' do
      before { delete :destroy, params: { id: blog } }

      it_behaves_like :redirected_request, 'new_user_session_url'

      it 'does not destroy a blog article' do
        expect { subject }.to change(Blog, :count).by(0)
      end
    end

    context 'any user' do
      let(:blog) { create(:blog) }
      let!(:comment) { create_list(:comment, 4, commentable: blog, user: blog.user) }

      before { sign_in blog.user }

      it 'destroys comments linked' do
        expect { subject }.to change(Comment, :count).by(-4)
      end
    end

    context 'an author' do
      let!(:blog) { create(:blog, :author) }

      before do
        sign_in blog.user
        subject
      end

      it_behaves_like :blog_destroyable
    end

    context 'an admin' do
      let(:admin) { create(:user, :admin) }

      context 'with its own articles' do
        let!(:blog) { create(:blog, user: admin) }

        before do
          sign_in admin
          subject
        end

        it_behaves_like :blog_destroyable
      end

      context 'when try to access a master' do
        let!(:blog) { create(:blog, :master) }

        before do
          sign_in admin
          subject
        end

        it_behaves_like :cancan_unauthorized_request, 'root_url', 'unauthorized.destroy.blog'
      end
    end

    context 'a master' do
      let!(:blog) { create(:blog, :master) }

      before do
        sign_in blog.user
        subject
      end

      it_behaves_like :blog_destroyable
    end
  end
end
