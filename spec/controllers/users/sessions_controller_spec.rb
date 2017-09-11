require 'rails_helper'

RSpec.describe Users::SessionsController do
  let(:user) { create :user }
  let(:attributes) { valid_attributes[:user] }
  let(:valid_attributes) do
    { user: { email: user.email,
              password: user.password } }
  end

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

    context 'with valid credentials' do
      let(:flash_type) { 'success' }
      let(:flash_message) { 'Vous êtes maintenant connecté' }

      it { is_expected.to have_http_status 302 }
      it { is_expected.to redirect_to user_url(user) }

      it_behaves_like :flash_message
    end

    context 'with invalid credentials' do
      let(:flash_type) { 'alert' }
      let(:flash_message) { 'Veuillez vérifier vos informations de connexion' }
      let(:attributes) do
        valid_attributes[:user][:email] = 'fakeemail@test.fr'
        valid_attributes[:user]
      end

      it { is_expected.to have_http_status 200 }
      it { is_expected.to render_template :new }

      it_behaves_like :flash_message
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy }

    let(:flash_type) { 'notice' }
    let(:flash_message) { 'Vous êtes maintenant déconnecté' }

    before { login_user user }

    it { is_expected.to have_http_status 302 }
    it { is_expected.to redirect_to root_url }

    it_behaves_like :flash_message
  end
end
