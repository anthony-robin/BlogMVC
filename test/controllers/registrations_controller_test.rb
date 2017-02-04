require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'should access sign up page if not connected yet' do
    sign_out @user
    get new_user_registration_url
    assert_response :success
  end

  test 'should not access sign up path if already signed in' do
    get new_user_registration_url
    assert_redirected_to root_url
  end
end
