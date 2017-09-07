require 'rails_helper'

RSpec.describe ContactMailer do
  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  before { ActionMailer::Base.deliveries = [] }
  after { ActionMailer::Base.deliveries.clear }

  describe '#send_email' do
    subject(:email) { described_class.send_email(attributes) }

    let(:attributes) { valid_attributes[:contact] }

    it 'renders the subject' do
      expect(email.subject).to eq(I18n.t('contact_mailer.send_email.subject'))
    end

    it 'renders the receiver email' do
      expect(email.to).to eq([ENV.fetch('TO_CONTACT')])
    end

    it 'renders the sender email' do
      expect(email.from).to eq(['johndoe@test.fr'])
    end

    it 'renders the body' do
      expect(email.body.encoded).to match('My contact message')
    end
  end

  describe '#copy_email' do
    subject(:copy) { described_class.copy_email(attributes) }

    let(:attributes) { valid_attributes[:contact] }

    it 'renders the subject' do
      expect(copy.subject).to eq(I18n.t('contact_mailer.copy_email.subject'))
    end

    it 'renders the receiver email' do
      expect(copy.to).to eq(['johndoe@test.fr'])
    end

    it 'renders the sender email' do
      expect(copy.from).to eq([ENV.fetch('TO_CONTACT')])
    end

    it 'renders the body' do
      expect(copy.body.encoded).to match('My contact message')
    end
  end
end
