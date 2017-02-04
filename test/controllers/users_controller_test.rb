require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test 'should get index if connected' do
    get users_url
    assert_response :success
  end

  test 'should not get index if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      get users_url
    end
  end

  test 'should destroy users blogs articles when user destroy his account' do
    assert_difference('Blog.count', -2) do
      delete user_registration_url
    end

    assert_redirected_to root_url
  end
end
