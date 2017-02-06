require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  # --------------
  # Non connected
  # --------------
  context 'A non connected user' do
    should 'access sign up page' do
      get new_user_registration_url
      assert_response :success
    end
  end

  # --------------
  # Connected
  # --------------
  context 'A connected user' do
    setup do
      @author = users(:author)
      sign_in @author
    end

    should 'not access sign up path' do
      get new_user_registration_url
      assert_redirected_to root_url
    end
  end
end
