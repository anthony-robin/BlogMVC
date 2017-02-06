require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:one)
  end

  # --------------
  # Non connected
  # --------------
  context 'A non connected user' do
    should 'not get index' do
      sign_out_and_ensure_redirect_to_sign_in do
        get categories_url
      end
    end

    should 'not get new' do
      sign_out_and_ensure_redirect_to_sign_in do
        get new_category_url
      end
    end

    should 'not create category' do
      sign_out_and_ensure_redirect_to_sign_in do
        assert_no_difference('Category.count') do
          post categories_url, params: { category: { name: 'bolobolo' } }
        end
      end
    end

    should 'not get edit' do
      sign_out_and_ensure_redirect_to_sign_in do
        get edit_category_url(@category)
      end
    end

    should 'not update category' do
      sign_out_and_ensure_redirect_to_sign_in do
        patch category_url(@category), params: { category: { name: @category.name, slug: @category.slug } }
      end
    end

    should 'not destroy category' do
      assert_no_difference('Category.count') do
        delete category_url(@category)
      end
    end

    should 'not destroy blogs linked to category' do
      assert_no_difference('Blog.count') do
        delete category_url(@category)
      end
    end
  end

  # --------------
  # Author
  # --------------
  context 'An author' do
    setup do
      @author = users(:author)
      sign_in @author
    end

    should 'not get index' do
      sign_in users(:author)
      get categories_url
      assert_redirected_to root_url
      assert_not flash[:alert].empty?
      assert_equal I18n.t('unauthorized.read.category'), flash[:alert]
    end

    should 'not get new' do
      get new_category_url
      assert_redirected_to root_url
    end

    should 'not create category' do
      assert_no_difference('Category.count') do
        post categories_url, params: { category: { name: 'bolobolo' } }
      end
      assert_redirected_to root_url
    end

    should 'not get edit' do
      get edit_category_url(@category)
      assert_redirected_to root_url
    end

    should 'not update category' do
      patch category_url(@category), params: { category: { name: @category.name, slug: @category.slug } }
      assert_redirected_to root_url
    end

    should 'not destroy category' do
      assert_no_difference('Category.count') do
        delete category_url(@category)
      end
      assert_redirected_to root_url
    end

    should 'not destroy blogs linked to category' do
      assert_no_difference('Blog.count') do
        delete category_url(@category)
      end
      assert_redirected_to root_url
    end
  end

  # --------------
  # Admin
  # --------------
  context 'An admin' do
    setup do
      @admin = users(:admin)
      sign_in @admin
    end

    should 'get index' do
      get categories_url
      assert_response :success
      assert_template :index
    end

    should 'get new' do
      get new_category_url
      assert_response :success
      assert_template :new
    end

    should 'create category' do
      assert_difference('Category.count') do
        post categories_url, params: { category: { name: 'bolobolo' } }
      end
      assert_redirected_to categories_url
    end

    should 'not create category if any errors' do
      assert_no_difference('Category.count') do
        post categories_url, params: { category: { name: '' } }
      end
      assert_response :success
      assert_template :new
    end

    should 'get edit' do
      get edit_category_url(@category)
      assert_response :success
      assert_template :edit
    end

    should 'update category' do
      patch category_url(@category), params: { category: { name: @category.name, slug: @category.slug } }
      assert_redirected_to categories_url
    end

    should 'not update category if any errors' do
      patch category_url(@category), params: { category: { name: '' } }
      assert_response :success
      assert_template :edit
    end

    should 'destroy category' do
      assert_difference('Category.count', -1) do
        delete category_url(@category)
      end
      assert_redirected_to categories_url
    end

    should 'destroy blogs linked to category' do
      assert_difference('Blog.count', -2) do
        delete category_url(@category)
      end
      assert_redirected_to categories_url
    end
  end

  # --------------
  # Master
  # --------------
  context 'A master' do
    setup do
      @master = users(:master)
      sign_in @master
    end

    should 'get index' do
      get categories_url
      assert_response :success
      assert_template :index
    end

    should 'get new' do
      get new_category_url
      assert_response :success
      assert_template :new
    end

    should 'create category' do
      assert_difference('Category.count') do
        post categories_url, params: { category: { name: 'bolobolo' } }
      end
      assert_redirected_to categories_url
    end

    should 'not create category if any errors' do
      assert_no_difference('Category.count') do
        post categories_url, params: { category: { name: '' } }
      end
      assert_response :success
      assert_template :new
    end

    should 'get edit' do
      get edit_category_url(@category)
      assert_response :success
      assert_template :edit
    end

    should 'update category' do
      patch category_url(@category), params: { category: { name: @category.name, slug: @category.slug } }
      assert_redirected_to categories_url
    end

    should 'not update category if any errors' do
      patch category_url(@category), params: { category: { name: '' } }
      assert_response :success
      assert_template :edit
    end

    should 'destroy category' do
      assert_difference('Category.count', -1) do
        delete category_url(@category)
      end
      assert_redirected_to categories_url
    end

    should 'destroy blogs linked to category' do
      assert_difference('Blog.count', -2) do
        delete category_url(@category)
      end
      assert_redirected_to categories_url
    end
  end

  # --------------
  # Abilities
  # --------------
  should 'test abilities for not connected user' do
    ability = Ability.new(User.new)
    assert ability.cannot?(:create, Category.new), 'should not be able to create'
    assert ability.cannot?(:read, @category), 'should not be able to read'
    assert ability.cannot?(:update, @category), 'should not be able to update'
    assert ability.cannot?(:destroy, @category), 'should not be able to destroy'
  end

  should 'test abilities for master role' do
    ability = Ability.new(users(:master))
    assert ability.can?(:create, Category.new), 'should be able to create'
    assert ability.can?(:read, @category), 'should be able to read'
    assert ability.can?(:update, @category), 'should be able to update'
    assert ability.can?(:destroy, @category), 'should be able to destroy'
  end

  should 'test abilities for admin role' do
    ability = Ability.new(users(:admin))
    assert ability.can?(:create, Category.new), 'should be able to create'
    assert ability.can?(:read, @category), 'should be able to read'
    assert ability.can?(:update, @category), 'should be able to update'
    assert ability.can?(:destroy, @category), 'should be able to destroy'
  end

  should 'test abilities for author role' do
    ability = Ability.new(users(:author))
    assert ability.cannot?(:create, Category.new), 'should not be able to create'
    assert ability.cannot?(:read, @category), 'should not be able to read'
    assert ability.cannot?(:update, @category), 'should not be able to update'
    assert ability.cannot?(:destroy, @category), 'should not be able to destroy'
  end
end
