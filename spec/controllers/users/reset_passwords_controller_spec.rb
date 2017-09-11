require 'rails_helper'

RSpec.describe Users::ResetPasswordsController do
  let(:user) { create :user }

  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to have_http_status 200 }
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do
    subject do
      post :create,
        params: { user: attributes }
    end

    before { allow(UserMailer).to receive(:reset_password_email) }

    context 'when user does not exist' do
      let(:attributes) { { email: 'fake@email.test' } }
      let(:flash_type) { 'alert' }
      let(:flash_message) { "Une erreur s'est produite, veuillez vérifier l'email que vous avez saisi." }

      it { is_expected.to have_http_status 302 }
      it_behaves_like :flash_message

      it 'does not call the mailer class' do
        expect(UserMailer).to_not have_received(:reset_password_email)
      end
    end

    context 'when user exists' do
      let(:attributes) { { email: user.email } }
      let(:flash_type) { 'notice' }
      let(:flash_message) { 'Les instructions pour modifier votre mot de passe ont été envoyées sur votre email.' }

      it { is_expected.to have_http_status 302 }
      it_behaves_like :flash_message

      it 'calls the mailer class' do
        expect(UserMailer).to have_received(:reset_password_email).with(user)
      end
    end
  end

  describe 'GET #edit' do
    subject { get :edit, params: { id: token } }

    let(:user) { create :user, :with_lost_password }
    let(:token) { user.reset_password_token }

    it_behaves_like :reset_password_invalid_token

    context 'with valid token' do
      it { is_expected.to have_http_status 200 }
      it { is_expected.to render_template :edit }
    end
  end

  describe 'PATCH #update' do
    subject { patch :update, params: { id: token, user: attributes } }

    let(:user) { create :user, :with_lost_password }
    let(:token) { user.reset_password_token }
    let(:password) { 'my_new_password_123' }
    let(:password_confirmation) { password }

    let(:attributes) do
      { password: password, password_confirmation: password_confirmation }
    end

    it_behaves_like :reset_password_invalid_token

    context 'with valid token' do
      let(:flash_type) { 'notice' }
      let(:flash_message) { 'Votre mot de passe a bien été mis à jour.' }

      it { is_expected.to have_http_status 302 }
      it_behaves_like :flash_message

      context 'when password mismatch password_confirmation' do
        let(:password_confirmation) { 'wrong confirmation' }

        it { is_expected.to have_http_status 200 }
        it { is_expected.to render_template :edit }
      end
    end
  end
end
