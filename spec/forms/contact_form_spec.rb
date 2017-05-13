require 'rails_helper'

describe ContactForm, type: :model do
  let(:i18n_scope) { %i[errors attributes] }
  let(:valid_attributes) do
    { contact: { name: 'John Doe',
                 email: 'johndoe@test.fr',
                 message: 'My contact message' } }
  end

  before { @form = ContactForm.new }

  context 'model validations rules' do
    subject { @form }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_absence_of(:nickname) }

    it { is_expected.to allow_value('lorem@ipsum.com').for(:email) }
    it { is_expected.to_not allow_value('loremipsum.com').for(:email).with_message(t('email.invalid', scope: i18n_scope)) }
  end

  context '#validate?' do
    subject! { @form.validate(attributes) }

    context 'with correct attributes' do
      let(:attributes) { valid_attributes[:contact] }
      it { is_expected.to be true }
    end

    context 'with empty name' do
      let(:attributes) { valid_attributes[:contact].merge!(name: '') }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(@form.errors[:name]).to eq [t('name.blank', scope: i18n_scope)]
      end
    end

    context 'with empty email' do
      let(:attributes) { valid_attributes[:contact].merge!(email: '') }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(@form.errors[:email]).to eq [t('email.blank', scope: i18n_scope), t('email.invalid', scope: i18n_scope)]
      end
    end

    context 'with incorrect email' do
      let(:attributes) { valid_attributes[:contact].merge!(email: 'fakeemail') }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(@form.errors[:email]).to eq [t('email.invalid', scope: i18n_scope)]
      end
    end

    context 'with empty message' do
      let(:attributes) { valid_attributes[:contact].merge!(message: '') }

      it { is_expected.to be false }

      it 'has correct error message' do
        expect(@form.errors[:message]).to eq [t('message.blank', scope: i18n_scope)]
      end
    end

    context 'with captcha filled' do
      let(:attributes) { valid_attributes[:contact].merge!(nickname: 'I am a robot !') }

      it { is_expected.to be false }

      it 'has no error message' do
        expect(@form.errors[:nickname]).to eq [t('nickname.present', scope: i18n_scope)]
      end
    end
  end
end
