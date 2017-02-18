require 'rails_helper'

describe UsersController do
  describe 'GET #index' do
    context 'a non connected user' do
      before { get :index }
      it_behaves_like :redirected_request, 'new_user_session_url'
    end

    context 'a connected user' do
      context 'as author' do
        login_user(:author)
        before { get :index }
        it_behaves_like :ok_request, 'index'
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

  describe 'GET #show' do
    context 'a non connected user' do
      before { get :show, params: { id: create(:user, :author) } }
      it_behaves_like :ok_request, 'show'
    end

    context 'a connected user' do
      context 'as author' do
        let(:login_as) { :author }
        before { get :show, params: { id: create(:user, :admin) } }
        it_behaves_like :ok_request, 'show'
      end

      context 'as admin' do
        let(:login_as) { :admin }
        before { get :show, params: { id: create(:user, :master) } }
        it_behaves_like :ok_request, 'show'
      end

      context 'as master' do
        let(:login_as) { :master }
        before { get :show, params: { id: create(:user, :author) } }
        it_behaves_like :ok_request, 'show'
      end
    end
  end
end
