ENV['RAILS_ENV'] ||= 'test'
require 'simplecov'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  private

  def sign_out_and_ensure_redirect_to_sign_in(user = users(:master))
    sign_out user
    yield
  ensure
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  def valid_blog_params
    {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: Category.first.id
    }
  end
end
