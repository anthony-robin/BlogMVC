require 'test_helper'

class UserTest < ActiveSupport::TestCase
  should have_many(:blogs)

  # Presence
  should validate_presence_of(:username)
    .with_message(I18n.t('errors.attributes.username.blank'))
  should validate_presence_of(:email)
    .with_message(I18n.t('errors.attributes.email.blank'))

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
end
