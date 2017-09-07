require 'rails_helper'

RSpec.describe RegistrationsController do
  let!(:user) { create(:user) }

  before { login_user user }

  describe 'GET #new' do
    subject { get :new }

    context 'when not logged in' do
      before { sign_out user }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }
    end

    context 'when connected' do
      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to root_url }
    end
  end

  describe 'DELETE #destroy' do
    subject(:destroy_user) do
      delete :destroy,
        params: { id: user }
    end

    before { create_list(:blog, 4, user: user) }

    it 'removes user account' do
      expect { destroy_user }.to change(User, :count).by(-1)
    end

    it 'removes user blogs articles' do
      expect { destroy_user }.to change(Blog, :count).by(-4)
    end
  end
end
