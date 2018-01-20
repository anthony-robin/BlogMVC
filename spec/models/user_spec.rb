require 'rails_helper'

RSpec.describe User do
  let(:i18n_scope) { %i[errors attributes] }

  it { is_expected.to have_many(:blogs) }

  describe 'validations rules' do
    describe '#presence' do
      it { is_expected.to validate_presence_of(:username).with_message(t('errors.attributes.username.blank')) }
      it { is_expected.to validate_presence_of(:email).with_message(t('errors.attributes.email.blank')) }
      it { is_expected.to validate_presence_of(:role).with_message(t('errors.attributes.role.blank')).on(:update) }
      it { is_expected.to_not validate_presence_of(:role).on(:create) }
    end

    describe '#uniqueness' do
      let(:user) { create(:user) }

      it { is_expected.to_not allow_value(user.username).for(:username).with_message(t('username.taken', scope: i18n_scope)) }
      it { is_expected.to_not allow_value(user.username.capitalize).for(:username).with_message(t('username.taken', scope: i18n_scope)) }

      it { is_expected.to_not allow_value(user.email).for(:email).with_message(t('email.taken', scope: i18n_scope)) }
      it { is_expected.to_not allow_value(user.email.capitalize).for(:email).with_message(t('email.taken', scope: i18n_scope)) }
    end

    describe '#format' do
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

    describe '#enum' do
      it { is_expected.to define_enum_for(:role).with(described_class.roles.keys) }
    end
  end

  describe 'a user' do
    describe 'on create' do
      let(:user) { build(:user) }

      it { expect(user).to be_valid }
      it { expect(user.errors).to be_empty }

      it 'has default user role' do
        expect(user.role).to eq('author')
      end
    end
  end
end
