require 'rails_helper'

RSpec.describe ContactsController do
  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  describe 'GET #index' do
    subject { get :index }

    it { is_expected.to have_http_status(302) }
    it { is_expected.to redirect_to new_contact_url }
  end

  describe 'GET #new' do
    subject { get :new }

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :new }
  end

  describe 'POST #create' do
    subject(:create_contact) do
      post :create,
        params: { contact: attributes }
    end

    let(:attributes) { valid_attributes[:contact] }

    before { ActionMailer::Base.deliveries = [] }
    after { ActionMailer::Base.deliveries.clear }

    context 'valid attributes' do
      it { is_expected.to have_http_status(302) }
      it { is_expected.to redirect_to new_contact_url }

      context 'without copy' do
        it 'sends an email' do
          expect { create_contact }.to change { ActionMailer::Base.deliveries.count }.by(1)
        end
      end

      context 'with copy' do
        let(:attributes) { valid_attributes[:contact].merge!(copy: '1') }

        it 'sends two emails' do
          expect { create_contact }.to change { ActionMailer::Base.deliveries.count }.by(2)
        end
      end

      describe 'flash message' do
        before { create_contact }

        it 'has correct message' do
          expect(controller).to set_flash[:notice].to t('contacts.create.notice')
        end
      end
    end

    context 'invalid attributes' do
      let(:attributes) { { name: '' } }

      it { is_expected.to have_http_status(200) }
      it { is_expected.to render_template :new }

      it 'does not send an email' do
        expect { create_contact }.to change { ActionMailer::Base.deliveries.count }.by(0)
      end
    end
  end
end
