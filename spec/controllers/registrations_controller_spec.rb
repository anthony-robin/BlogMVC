require 'rails_helper'

RSpec.describe RegistrationsController do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    context 'a non connected user' do
      subject! { get :new }
      it_behaves_like :ok_request, 'new'
    end

    context 'a connected user' do
      login_user(:author)
      subject! { get :new }

      it_behaves_like :redirected_request, 'root_url'
    end
  end

  describe 'DELETE #destroy' do
    login_user(:admin)

    it 'should remove user account' do
      expect do
        delete :destroy, params: { id: @admin }
      end.to change(User, :count).by(-1)
    end

    it 'should remove user blogs article' do
      create_list(:blog, 4, user: @admin)
      expect do
        delete :destroy, params: { id: @admin }
      end.to change(Blog, :count).by(-4)
    end
  end
end
