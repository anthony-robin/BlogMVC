require 'rails_helper'

RSpec.describe UserForm, type: :model do
  subject { described_class.new(User.new) }

  let!(:user) { create :user, username: 'John Snow' }

  describe '#username' do
    let(:username_blank) { 'Vous devez renseigner votre pseudo' }
    let(:username_taken) { "Ce nom d'utilisateur n'est pas disponible" }
    let(:username_invalid) { "Ce nom d'utilisateur n'est pas valide" }

    it { is_expected.to validate_presence_of(:username).with_message(username_blank) }

    it { is_expected.to allow_value('foobar').for(:username) }
    it { is_expected.to allow_value('foobar123').for(:username) }
    it { is_expected.to allow_value('foobar_123').for(:username) }
    it { is_expected.to allow_value('foobar-123').for(:username) }
    it { is_expected.to allow_value('fOobaR').for(:username) }
    it { is_expected.to allow_value('Foo Bar').for(:username) }
    it { is_expected.to_not allow_value('John Snow').for(:username).with_message(username_taken) }
    it { is_expected.to_not allow_value('john snow').for(:username).with_message(username_taken) }

    it { is_expected.to_not allow_value('foobar@test.fr').for(:username).with_message(username_invalid) }
    it { is_expected.to_not allow_value('foobar%$').for(:username).with_message(username_invalid) }
  end

  describe '#email' do
    let(:email_blank) { 'Vous devez saisir votre email' }
    let(:email_taken) { "Cet email n'est pas disponible" }
    let(:email_invalid) { 'Vous devez renseigner un email valide' }

    it { is_expected.to validate_presence_of(:email).with_message(email_blank) }

    it { is_expected.to_not allow_value(user.email).for(:email).with_message(email_taken) }
    it { is_expected.to_not allow_value(user.email.capitalize).for(:email).with_message(email_taken) }

    it { is_expected.to allow_value('lorem@ipsum.com').for(:email) }
    it { is_expected.to_not allow_value('loremipsum.com').for(:email).with_message(email_invalid) }
  end

  # describe '#password' do
  #   describe '#valid?' do
  #     subject! { user.valid? }
  #
  #     let(:user) do
  #       build :user,
  #         password: 'mypassword',
  #         password_confirmation: 'mypassword2'
  #     end
  #
  #     it { is_expected.to be false }
  #
  #     it 'has correct errors' do
  #       expect(user.errors[:password_confirmation].first).to_not be_empty
  #     end
  #   end
  # end

  describe '#role' do
    let(:role_blank) { 'Vous devez spécifier un rôle pour cet utilisateur' }

    it { is_expected.to validate_presence_of(:role).with_message(role_blank) }

    it do
      is_expected.to validate_inclusion_of(:role).
        in_array(%w[master admin author])
    end

    it { is_expected.to have_attributes role: 'author' }
  end
end
