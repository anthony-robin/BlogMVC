require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:blogs)

  # Presence
  should validate_presence_of(:username)
    .with_message(I18n.t('errors.attributes.username.blank'))
  should validate_presence_of(:email)
    .with_message(I18n.t('errors.attributes.email.blank'))
  should validate_presence_of(:role)
    .with_message(I18n.t('errors.attributes.role.blank'))
    .on(:update)
  should_not validate_presence_of(:role)
    .on(:create)

  # Uniqueness
  should validate_uniqueness_of(:username)
    .with_message(I18n.t('errors.messages.taken'))
  should validate_uniqueness_of(:email)
    .with_message(I18n.t('errors.attributes.email.taken'))
  should_not allow_value('admin@test.fr').for(:email)
    .with_message(I18n.t('errors.attributes.email.taken'))

  # Format
  should allow_value('foobar').for(:username)
  should allow_value('foobar123').for(:username)
  should allow_value('foobar_123').for(:username)
  should allow_value('foobar-123').for(:username)
  should allow_value('fOobaR').for(:username)
  should allow_value('Foo Bar').for(:username)
  should_not allow_value('foobar@test.fr').for(:username)
    .with_message(I18n.t('errors.attributes.username.invalid'))
  should_not allow_value('foobar%$').for(:username)
    .with_message(I18n.t('errors.attributes.username.invalid'))

  should allow_value('lorem@ipsum.com').for(:email)
  should_not allow_value('loremipsum.com').for(:email)
    .with_message(I18n.t('errors.attributes.email.invalid'))

  # Enum
  should define_enum_for(:role)
    .with(User.roles.keys)

  context 'A user' do
    should 'not be valid if password mismatch password_confirmation' do
      attrs = default_attrs
      attrs[:password] = 'mypassword'
      attrs[:password_confirmation] = 'mypassword2'
      user = User.new attrs
      assert_not user.valid?, 'user should not be valid'
      assert_equal [:password_confirmation], user.errors.keys
    end

    context 'on create' do
      should 'have default user role' do
        user = User.new default_attrs
        assert user.valid?, 'user should be valid'
        assert_equal 'author', user.role
        assert_empty user.errors.keys
      end
    end
  end

  private

  def default_attrs
    {
      username: 'John Cena',
      email: 'john@cena.fr',
      password: 'mypassword',
      password_confirmation: 'mypassword'
    }
  end
end
