require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user2 = users(:two)
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

  # --------------
  # Abilities
  # --------------
  test 'should test abilities for not connected user' do
    ability = Ability.new(User.new)
    assert ability.cannot?(:create, User.new), 'should not be able to create'
    assert ability.cannot?(:read, @user), 'should not be able to read'
    assert ability.cannot?(:update, @user), 'should not be able to update'
    assert ability.cannot?(:destroy, @user), 'should not be able to destroy'
  end

  test 'should test abilities for connected user' do
    ability = Ability.new(@user)
    assert ability.can?(:read, @user), 'should be able to read'
    assert ability.can?(:update, @user), 'should be able to update'
    assert ability.can?(:destroy, @user), 'should be able to destroy'
  end

  test 'should have abilities to only manage own profile' do
    ability = Ability.new(@user)
    assert ability.cannot?(:read, @user2), 'should be able to read'
    assert ability.cannot?(:update, @user2), 'should be able to update'
    assert ability.cannot?(:destroy, @user2), 'should be able to destroy'
  end
end
