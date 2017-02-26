require 'rails_helper'

describe User do
  context 'associations' do
    it { should have_many(:blogs) }
  end

  context 'validations rules' do
    context 'presence' do
      it { should validate_presence_of(:username).with_message(t('errors.attributes.username.blank')) }
      it { should validate_presence_of(:email).with_message(t('errors.attributes.email.blank')) }
      it { should validate_presence_of(:role).with_message(t('errors.attributes.role.blank')).on(:update) }
      it { should_not validate_presence_of(:role).on(:create) }
    end

    context 'uniqueness' do
      let(:user) { create(:user) }

      it 'should have a unique (case insensitive) username' do
        create(:user, username: 'Foobar')
        user2 = build(:user, username: 'fooBar')
        expect(user2).to_not be_valid
        expect(user2.errors[:username]).to include(t('errors.attributes.username.taken'))
      end

      it 'should have a unique (case insensitive) email' do
        create(:user, email: 'foobar@example.com')
        user2 = build(:user, email: 'FOOBAR@example.com')
        expect(user2).to_not be_valid
        expect(user2.errors[:email]).to include(t('errors.attributes.email.taken'))
      end

      it { should_not allow_value(user.username).for(:username).with_message(t('errors.attributes.username.taken')) }
      it { should_not allow_value(user.email).for(:email).with_message(t('errors.attributes.email.taken')) }
    end

    context 'format' do
      it { should allow_value('foobar').for(:username) }
      it { should allow_value('foobar123').for(:username) }
      it { should allow_value('foobar_123').for(:username) }
      it { should allow_value('foobar-123').for(:username) }
      it { should allow_value('fOobaR').for(:username) }
      it { should allow_value('Foo Bar').for(:username) }

      it { should_not allow_value('foobar@test.fr').for(:username).with_message(t('errors.attributes.username.invalid')) }
      it { should_not allow_value('foobar%$').for(:username).with_message(t('errors.attributes.username.invalid')) }

      it { should allow_value('lorem@ipsum.com').for(:email) }
      it { should_not allow_value('loremipsum.com').for(:email).with_message(t('errors.attributes.email.invalid')) }
    end

    context 'enum' do
      it { should define_enum_for(:role).with(User.roles.keys) }
    end
  end

  context 'a user' do
    it 'should not be valid if password mismatch password_confirmation' do
      user = build(:user, password: 'mypassword', password_confirmation: 'mypassword2')
      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation].first).to_not be_empty
    end

    context 'on create' do
      it 'should have default user role' do
        user = build(:user)
        expect(user).to be_valid
        expect(user.errors).to be_empty
        expect(user.role).to eq('author')
      end
    end
  end

  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'when is not connected' do
      it { should_not be_able_to(:create, User.new) }
      it { should be_able_to(:read, create(:user, :author)) }
      it { should_not be_able_to(:update, create(:user, :author)) }
      it { should_not be_able_to(:destroy, create(:user, :author)) }
    end

    context 'when is an author' do
      let(:user) { create(:user, :author) }
      it { should_not be_able_to(:create, User.new) }
      it { should be_able_to(:read, user) }
      it { should be_able_to(:update, user) }
      it { should be_able_to(:destroy, user) }
    end

    context 'when is an admin' do
      let(:user) { create(:user, :admin) }
      it { should_not be_able_to(:create, User.new) }
      it { should be_able_to(:read, user) }
      it { should be_able_to(:update, user) }
      it { should be_able_to(:destroy, user) }
    end

    context 'when is a master' do
      let(:user) { create(:user, :master) }
      it { should be_able_to(:create, User.new) }
      it { should be_able_to(:read, user) }
      it { should be_able_to(:update, user) }
      it { should be_able_to(:destroy, user) }
    end

    context 'user can only manage own profile' do
      let(:user) { create(:user, :admin) }
      let(:user2) { create(:user, :author) }
      it { should_not be_able_to(:create, User.new) }
      it { should be_able_to(:read, user2) }
      it { should_not be_able_to(:update, user2) }
      it { should_not be_able_to(:destroy, user2) }
    end
  end
end
