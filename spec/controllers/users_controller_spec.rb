require 'rails_helper'

RSpec.describe UsersController do
  describe 'GET #index' do
    context 'a non connected user' do
      subject! { get :index }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'as author' do
      login_user(:author)
      subject! { get :index }
      it_behaves_like :ok_request, 'index'
    end

    context 'as admin' do
      login_user(:admin)
      subject! { get :index }
      it_behaves_like :ok_request, 'index'
    end

    context 'as master' do
      login_user(:master)
      subject! { get :index }
      it_behaves_like :ok_request, 'index'
    end
  end

  describe 'GET #show' do
    context 'a non connected user' do
      subject! { get :show, params: { id: create(:user, :author) } }

      it_behaves_like :ok_request, 'show'
    end

    context 'as author' do
      let(:login_as) { :author }
      subject! { get :show, params: { id: create(:user, :admin) } }

      it_behaves_like :ok_request, 'show'
    end

    context 'as admin' do
      let(:login_as) { :admin }
      subject! { get :show, params: { id: create(:user, :master) } }

      it_behaves_like :ok_request, 'show'
    end

    context 'as master' do
      let(:login_as) { :master }
      subject! { get :show, params: { id: create(:user, :author) } }

      it_behaves_like :ok_request, 'show'
    end
  end
end
