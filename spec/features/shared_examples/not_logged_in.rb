RSpec.shared_examples_for :not_logged_in do |js: true|
  before { logout_user }

  context 'with HTML format' do
    let(:format) { :html }
    let(:flash_type) { 'alert' }
    let(:flash_message) { 'Vous devez vous connecter ou vous inscrire pour accéder à cette page' }

    it { is_expected.to have_http_status(302) }
    it { is_expected.to redirect_to new_sessions_url }

    it_behaves_like :flash_message
  end

  if js
    context 'with JS format' do
      let(:format) { :js }

      it { is_expected.to have_http_status(401) }
    end
  end
end
