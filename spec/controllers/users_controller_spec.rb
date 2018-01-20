require 'rails_helper'

RSpec.describe UsersController do
  before { login_user user }

  describe 'GET #index' do
    subject { get :index }

    context 'when not logged in' do
      let(:user) { create(:user) }

      it_behaves_like :not_logged_in, js: false
    end

    context 'when an author' do
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :index }
    end

    context 'when an admin' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :index }
    end

    context 'when a master' do
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :index }
    end
  end

  describe 'GET #show' do
    subject do
      get :show,
        params: { id: create(:user, role) }
    end

    context 'when not logged in' do
      let(:role) { :author }
      let(:user) { create(:user) }

      before { logout_user }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end

    context 'when an author' do
      let(:role) { :admin }
      let(:user) { create(:user, :author) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end

    context 'when an admin' do
      let(:role) { :master }
      let(:user) { create(:user, :admin) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end

    context 'when a master' do
      let(:role) { :author }
      let(:user) { create(:user, :master) }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
    end
  end
end
