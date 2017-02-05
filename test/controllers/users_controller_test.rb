require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @master = users(:master)
    @admin = users(:admin)
    @author = users(:author)
  end

  # --------------
  # Non connected
  # --------------
  context 'A non connected user' do
    should 'not get index' do
      sign_out_and_ensure_redirect_to_sign_in do
        get users_url
      end
    end

    should 'get show' do
      get user_url(@author)
      assert_response :success
    end

    should 'have correct abilities' do
      ability = Ability.new(User.new)
      assert ability.can?(:create, User.new), 'should be able to create'
      assert ability.can?(:read, @author), 'should be able to read'
      assert ability.cannot?(:update, @author), 'should not be able to update'
      assert ability.cannot?(:destroy, @author), 'should not be able to destroy'
    end
  end

  # --------------
  # Author
  # --------------
  context 'An author' do
    setup do
      sign_in @author
    end

    should 'get index' do
      get users_url
      assert_response :success
    end

    should 'get show' do
      get user_url(@admin)
      assert_response :success
    end

    should 'destroy users blogs articles when his account is destroyed' do
      assert_difference('Blog.count', -1) do
        delete user_registration_url
      end
      assert_redirected_to root_url
    end

    should 'have correct abilities' do
      ability = Ability.new(@author)
      assert ability.can?(:read, @author), 'should be able to read'
      assert ability.can?(:update, @author), 'should be able to update'
      assert ability.can?(:destroy, @author), 'should be able to destroy'
    end
  end

  # --------------
  # Admin
  # --------------
  context 'An admin' do
    setup do
      sign_in @admin
    end

    should 'get index' do
      get users_url
      assert_response :success
    end

    should 'get show' do
      get user_url(@master)
      assert_response :success
    end

    should 'destroy users blogs articles when his account is destroyed' do
      assert_difference('Blog.count', -1) do
        delete user_registration_url
      end
      assert_redirected_to root_url
    end

    should 'have correct abilities' do
      ability = Ability.new(@admin)
      assert ability.can?(:read, @admin), 'should be able to read'
      assert ability.can?(:update, @admin), 'should be able to update'
      assert ability.can?(:destroy, @admin), 'should be able to destroy'
    end
  end

  # --------------
  # Master
  # --------------
  context 'A master' do
    setup do
      sign_in @master
    end

    should 'get index' do
      get users_url
      assert_response :success
    end

    should 'get show' do
      get user_url(@author)
      assert_response :success
    end

    should 'destroy users blogs articles when user destroy his account' do
      assert_difference('Blog.count', -2) do
        delete user_registration_url
      end
      assert_redirected_to root_url
    end

    should 'have correct abilities' do
      ability = Ability.new(@master)
      assert ability.can?(:read, @master), 'should be able to read'
      assert ability.can?(:update, @master), 'should be able to update'
      assert ability.can?(:destroy, @master), 'should be able to destroy'
    end
  end

  # --------------
  # Abilities
  # --------------
  should 'have abilities to only manage own profile' do
    ability = Ability.new(@admin)
    assert ability.can?(:read, @author), 'should be able to read'
    assert ability.cannot?(:update, @author), 'should not be able to update'
    assert ability.cannot?(:destroy, @author), 'should not be able to destroy'
  end
end
