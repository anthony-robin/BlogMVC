require 'rails_helper'

RSpec.describe ContactsController do
  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  describe 'GET #index' do
    subject! { get :index }
    it_behaves_like :redirected_request, 'new_contact_url'
  end

  describe 'GET #new' do
    subject! { get :new }
    it_behaves_like :ok_request, 'new'
  end

  describe 'POST #create' do
    subject { post :create, params: { contact: attributes } }
    before(:each) { ActionMailer::Base.deliveries = [] }
    after(:each) { ActionMailer::Base.deliveries.clear }

    context 'valid attributes' do
      let(:attributes) { valid_attributes[:contact] }

      it 'sends an email' do
        expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(1)
      end

      it 'sends two emails if copy is checked' do
        attributes.merge!(copy: '1')
        expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(2)
      end

      it 'has correct flash message' do
        subject
        expect(controller).to set_flash[:notice].to(t('contacts.create.notice'))
      end

      it_behaves_like :redirected_request, 'new_contact_url'
    end

    context 'invalid attributes' do
      let(:attributes) { { name: '' } }

      it_behaves_like :ok_request, 'new'

      it 'does not send an email' do
        expect { subject }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end
end
