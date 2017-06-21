require 'rails_helper'

RSpec.describe ContactMailer do
  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  before(:each) { ActionMailer::Base.deliveries = [] }
  after(:each) { ActionMailer::Base.deliveries.clear }

  describe '#send_email' do
    let(:attributes) { valid_attributes[:contact] }
    subject { described_class.send_email(attributes) }

    it 'renders the subject' do
      expect(subject.subject).to eq(I18n.t('contact_mailer.send_email.subject'))
    end

    it 'renders the receiver email' do
      expect(subject.to).to eq([ENV.fetch('TO_CONTACT')])
    end

    it 'renders the sender email' do
      expect(subject.from).to eq(['johndoe@test.fr'])
    end

    it 'renders the body' do
      expect(subject.body.encoded).to match('My contact message')
    end
  end

  describe '#copy_email' do
    let(:attributes) { valid_attributes[:contact] }
    subject { described_class.copy_email(attributes) }

    it 'renders the subject' do
      expect(subject.subject).to eq(I18n.t('contact_mailer.copy_email.subject'))
    end

    it 'renders the receiver email' do
      expect(subject.to).to eq(['johndoe@test.fr'])
    end

    it 'renders the sender email' do
      expect(subject.from).to eq([ENV.fetch('TO_CONTACT')])
    end

    it 'renders the body' do
      expect(subject.body.encoded).to match('My contact message')
    end
  end
end
