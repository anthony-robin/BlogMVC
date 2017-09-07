require 'rails_helper'

RSpec.describe Admin::DashboardsController do
  let(:user) { create(:user) }
  let(:format) { :html }

  before { login_user user }

  describe 'GET #show' do
    subject { get :show, format: format }

    it_behaves_like :not_logged_in

    context 'when logged in' do
      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
      it { is_expected.to render_template(layout: :admin) }
    end
  end
end
