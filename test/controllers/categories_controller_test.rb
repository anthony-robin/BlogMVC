require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
    sign_in users(:one)
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

  test 'should show category if connected' do
    get category_url(@category)
    assert_response :success
  end

  test 'should get edit if connected' do
    get edit_category_url(@category)
    assert_response :success
  end

  test 'should update category if connected' do
    patch category_url(@category), params: { category: { name: @category.name, slug: @category.slug } }
    assert_redirected_to categories_url
  end

  test 'should destroy category if connected' do
    assert_difference('Category.count', -1) do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
  end

  test 'should destroy blogs linked to category if connected' do
    assert_difference('Blog.count', -1) do
      delete category_url(@category)
    end
  end
end
