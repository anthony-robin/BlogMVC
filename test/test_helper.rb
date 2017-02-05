ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def sign_out_and_ensure_redirect_to_sign_in(user = users(:master))
    sign_out user
    yield
  ensure
    assert_response 302
    assert_redirected_to new_user_session_path
  end
end
