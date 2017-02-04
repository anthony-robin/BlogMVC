require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should get index if connected' do
    sign_in users(:one)
    get users_url
    assert_response :success
  end

  test 'should not get index if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      get users_url
    end
  end
end
