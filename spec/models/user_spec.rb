require 'rails_helper'

RSpec.describe User do
  let(:i18n_scope) { %i[errors attributes] }

  context 'associations' do
    it { is_expected.to have_many(:blogs) }
  end

  context 'validations rules' do
    context 'presence' do
      it { is_expected.to validate_presence_of(:username).with_message(t('errors.attributes.username.blank')) }
      it { is_expected.to validate_presence_of(:email).with_message(t('errors.attributes.email.blank')) }
      it { is_expected.to validate_presence_of(:role).with_message(t('errors.attributes.role.blank')).on(:update) }
      it { is_expected.to_not validate_presence_of(:role).on(:create) }
    end

    context 'uniqueness' do
      let(:user) { create(:user) }

      it 'has a unique (case insensitive) username' do
        create(:user, username: 'Foobar')
        user2 = build(:user, username: 'fooBar')

        expect(user2).to_not be_valid
        expect(user2.errors[:username]).to include(t('username.taken', scope: i18n_scope))
      end

      it 'has a unique (case insensitive) email' do
        create(:user, email: 'foobar@example.com')
        user2 = build(:user, email: 'FOOBAR@example.com')
        expect(user2).to_not be_valid
        expect(user2.errors[:email]).to include(t('errors.attributes.email.taken'))
      end

      it { is_expected.to_not allow_value(user.username).for(:username).with_message(t('username.taken', scope: i18n_scope)) }
      it { is_expected.to_not allow_value(user.email).for(:email).with_message(t('email.taken', scope: i18n_scope)) }
    end

    context 'format' do
      it { is_expected.to allow_value('foobar').for(:username) }
      it { is_expected.to allow_value('foobar123').for(:username) }
      it { is_expected.to allow_value('foobar_123').for(:username) }
      it { is_expected.to allow_value('foobar-123').for(:username) }
      it { is_expected.to allow_value('fOobaR').for(:username) }
      it { is_expected.to allow_value('Foo Bar').for(:username) }

      it { is_expected.to_not allow_value('foobar@test.fr').for(:username).with_message(t('username.invalid', scope: i18n_scope)) }
      it { is_expected.to_not allow_value('foobar%$').for(:username).with_message(t('username.invalid', scope: i18n_scope)) }

      it { is_expected.to allow_value('lorem@ipsum.com').for(:email) }
      it { is_expected.to_not allow_value('loremipsum.com').for(:email).with_message(t('email.invalid', scope: i18n_scope)) }
    end

    context 'enum' do
      it { is_expected.to define_enum_for(:role).with(User.roles.keys) }
    end
  end

  context 'a user' do
    let(:user) { build(:user, password: 'mypassword', password_confirmation: 'mypassword2') }

    it 'is not valid if password mismatch password_confirmation' do
      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation].first).to_not be_empty
    end

    context 'on create' do
      let(:user) { build(:user) }

      it 'has default user role' do
        expect(user).to be_valid
        expect(user.errors).to be_empty
        expect(user.role).to eq('author')
      end
    end
  end
end
