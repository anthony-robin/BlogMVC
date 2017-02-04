require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    @user = users(:one)
    sign_in @user
  end

  test 'should get index if connected' do
    get categories_url
    assert_response :success
  end

  test 'should not get index if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      get categories_url
    end
  end

  test 'should get new if connected' do
    get new_category_url
    assert_response :success
  end

  test 'should not get new if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      get new_category_url
    end
  end

  test 'should create category if connected' do
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'bolobolo' } }
    end

    assert_redirected_to categories_url
  end

  test 'should not create category if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      assert_no_difference('Category.count') do
        post categories_url, params: { category: { name: 'bolobolo' } }
      end
    end
  end

  test 'should get edit if connected' do
    get edit_category_url(@category)
    assert_response :success
  end

  test 'should not get edit if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      get edit_category_url(@category)
    end
  end

  test 'should update category if connected' do
    patch category_url(@category), params: { category: { name: @category.name, slug: @category.slug } }
    assert_redirected_to categories_url
  end

  test 'should not update category if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      patch category_url(@category), params: { category: { name: @category.name, slug: @category.slug } }
    end
  end

  test 'should destroy category if connected' do
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end

  test 'should not destroy category if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      assert_no_difference('Category.count') do
        delete category_url(@category)
      end
    end
  end

  test 'should destroy blogs linked to category if connected' do
    assert_difference('Blog.count', -1) do
      delete category_url(@category)
    end
  end

  test 'should not destroy blogs linked to category if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      assert_no_difference('Blog.count') do
        delete category_url(@category)
      end
    end
  end

  # --------------
  # Abilities
  # --------------
  test 'should test abilities for not connected user' do
    ability = Ability.new(User.new)
    assert ability.cannot?(:create, Category.new), 'should not be able to create'
    assert ability.cannot?(:read, @category), 'should not be able to read'
    assert ability.cannot?(:update, @category), 'should not be able to update'
    assert ability.cannot?(:destroy, @category), 'should not be able to destroy'
  end

  test 'should test abilities for connected user' do
    ability = Ability.new(@user)
    assert ability.can?(:create, Category.new), 'should be able to create'
    assert ability.can?(:read, @category), 'should be able to read'
    assert ability.can?(:update, @category), 'should be able to update'
    assert ability.can?(:destroy, @category), 'should be able to destroy'
  end
end
