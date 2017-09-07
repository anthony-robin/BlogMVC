require 'rails_helper'

RSpec.describe Admin::DashboardsController do
  let(:user) { create(:user) }
  let(:format) { :html }

  before { login_user user }

  describe 'GET #show' do
    subject(:show) { get :show, format: format }

    context 'when not logged in' do
      it_behaves_like :not_logged_in

      describe 'flash message' do
        before do
          sign_out user
          show
        end

        it 'has correct message' do
          expect(flash[:alert]).to eq 'Vous devez vous connecter ou vous inscrire pour continuer.'
        end
      end
    end

    context 'when logged in' do
      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :show }
      it { is_expected.to render_template(layout: :admin) }
    end
  end
end
