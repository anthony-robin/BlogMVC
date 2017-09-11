require 'rails_helper'

RSpec.describe UserMailer do
  let(:user) { create :user, reset_password_token: 'my-token' }

  describe '#reset_password_email' do
    subject(:email) { described_class.reset_password_email(user) }

    let(:from) { ['contact@example.test'] }
    let(:to) { [user.email] }
    let(:subject) { 'Modification de votre mot de passe' }
    let(:body) { edit_reset_password_url(user.reset_password_token) }

    it_behaves_like :email_with_headers
  end
end
