RSpec.shared_examples_for :reset_password_invalid_token do
  context 'with fake token' do
    let(:token) { 'faketoken' }

    it_behaves_like :not_logged_in, js: false
  end

  context 'with expired token' do
    before { user.update_attribute(:reset_password_token_expires_at, 1.day.ago) }

    it_behaves_like :not_logged_in, js: false
  end
end
