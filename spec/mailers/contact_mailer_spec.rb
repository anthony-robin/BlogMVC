require 'rails_helper'

RSpec.describe ContactMailer do
  let(:attributes) { valid_attributes[:contact] }
  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  before { ActionMailer::Base.deliveries = [] }
  after { ActionMailer::Base.deliveries.clear }

  describe '#send_email' do
    subject(:email) { described_class.send_email(attributes) }

    let(:from) { ['johndoe@test.fr'] }
    let(:to) { ['contact@example.test'] }
    let(:subject) { 'Message de contact' }
    let(:body) { 'My contact message' }

    it_behaves_like :email_with_headers
  end

  describe '#copy_email' do
    subject(:email) { described_class.copy_email(attributes) }

    let(:from) { ['contact@example.test'] }
    let(:to) { ['johndoe@test.fr'] }
    let(:subject) { 'Copie du message de contact' }
    let(:body) { 'My contact message' }

    it_behaves_like :email_with_headers
  end
end
