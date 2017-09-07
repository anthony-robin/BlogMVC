RSpec.shared_examples_for :not_logged_in do |js: true|
  before { sign_out user }

  context 'with HTML format' do
    let(:format) { :html }

    it { is_expected.to have_http_status(302) }
    it { is_expected.to redirect_to new_user_session_path }
  end

  if js
    context 'with JS format' do
      let(:format) { :js }

      it { is_expected.to have_http_status(401) }
    end
  end
end
