require 'rails_helper'

RSpec.describe SessionForm, type: :model do
  subject { described_class.new(User.new) }

  describe 'presence' do
    let(:email_blank) { 'Vous devez saisir votre email' }
    let(:password_blank) { 'Vous devez saisir votre mot de passe' }

    it { is_expected.to validate_presence_of(:email).with_message(email_blank) }
    it { is_expected.to validate_presence_of(:password).with_message(password_blank) }
  end

  describe 'format' do
    let(:email_invalid) { 'Vous devez renseigner un email valide' }

    it { is_expected.to allow_value('foobar@test.fr').for(:email) }
    it { is_expected.to_not allow_value('foobar').for(:email).with_message(email_invalid) }
  end
end
