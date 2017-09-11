require 'rails_helper'

RSpec.describe UsersController do
  let(:user) { create :user }

  before { login_user user }

  describe 'GET #index' do
    subject { get :index }

    context 'when not logged in' do
      it_behaves_like :not_logged_in, js: false
    end

    context 'as author' do
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :index }
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
    subject { get :new }

    context 'when not logged in' do
      before { logout_user }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }
    end

    context 'when already logged in' do
      let(:flash_type) { 'alert' }
      let(:flash_message) { 'Vous êtes déjà inscrit et connecté' }

      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to user_url(user) }
      it_behaves_like :flash_message
    end
  end

  describe 'GET #show' do
    subject do
      get :show,
        params: { id: user }
    end

    let(:user) { create :user, role }

    context 'when not logged in' do
      let(:role) { :author }
      let(:user) { create(:user) }

      before { logout_user }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end

    context 'as author' do
      let(:role) { :admin }
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end

    context 'as admin' do
      let(:role) { :master }
      let(:user) { create(:user, :admin) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end

    context 'as master' do
      let(:role) { :author }
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end
  end

  describe 'DELETE #destroy' do
    subject(:destroy_user) do
      delete :destroy,
        params: { id: user }
    end

    let(:flash_type) { 'notice' }
    let(:flash_message) { 'Votre compte a bien été supprimé' }

    before { create_list(:blog, 4, user: user) }

    it_behaves_like :flash_message
    it { is_expected.to redirect_to root_url }

    it 'removes user account' do
      expect { destroy_user }.to change(User, :count).by(-1)
    end

    it 'removes user blogs articles' do
      expect { destroy_user }.to change(Blog, :count).by(-4)
    end
  end
end
