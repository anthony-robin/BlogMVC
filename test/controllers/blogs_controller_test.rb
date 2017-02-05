require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = blogs(:one)
    @user = users(:one)
    @user2 = users(:two)
    sign_in @user
  end

  test 'should get index' do
    get blogs_url
    assert_response :success
  end

  test 'should get new if connected' do
    get new_blog_url
    assert_response :success
  end

  test 'should not get new if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      get new_blog_url
    end
  end

  test 'should create blog if connected' do
    blog = {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: Category.first.id
    }
    assert_difference('Blog.count') do
      post blogs_url, params: { blog: blog }
    end

    last_blog = Blog.last
    assert_redirected_to category_blog_url(last_blog.category, last_blog)
  end

  test 'should not create blog if not connected' do
    blog = {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: Category.first.id
    }

    sign_out_and_ensure_redirect_to_sign_in do
      assert_no_difference('Blog.count') do
        post blogs_url, params: { blog: blog }
      end
    end
  end

  test 'should show blog' do
    get category_blog_url(@blog.category, @blog)
    assert_response :success
  end

  test 'should get edit if connected' do
    get edit_category_blog_url(@blog.category, @blog)
    assert_response :success
  end

  test 'should not get edit if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      get edit_category_blog_url(@blog.category, @blog)
    end
  end

  test 'should not get edit from another user' do
    sign_in @user2
    get edit_category_blog_url(@blog.category, @blog)
    assert_redirected_to root_url
    assert_not flash[:alert].empty?
    assert_equal I18n.t('unauthorized.update.blog'), flash[:alert]
  end

  test 'should update blog if connected' do
    blog = {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: @blog.category.id
    }
    patch blog_url(@blog), params: { blog: blog }
    @blog.reload
    assert_redirected_to category_blog_url(@blog.category, @blog)
  end

  test 'should not update blog if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      patch blog_url(@blog), params: { blog: {} }
    end
  end

  test 'should not update blog from another user' do
    sign_in @user2
    patch blog_url(@blog), params: { blog: {} }
    assert_redirected_to root_url
    assert_not flash[:alert].empty?
    assert_equal I18n.t('unauthorized.update.blog'), flash[:alert]
  end

  test 'should destroy blog if connected' do
    assert_difference('Blog.count', -1) do
      delete blog_url(@blog)
    end

    assert_redirected_to blogs_url
  end

  test 'should not destroy blog if not connected' do
    sign_out_and_ensure_redirect_to_sign_in do
      assert_no_difference('Blog.count') do
        delete blog_url(@blog)
      end
    end
  end

  test 'should not destroy blog from another user' do
    sign_in @user2
    delete blog_url(@blog)
    assert_redirected_to root_url
    assert_not flash[:alert].empty?
    assert_equal I18n.t('unauthorized.destroy.blog'), flash[:alert]
  end

  test 'should have correct owner for blog article' do
    blog = {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: Category.first.id
    }
    post blogs_url, params: { blog: blog }
    assert_equal users(:one), Blog.last.user
  end

  # --------------
  # Abilities
  # --------------
  test 'should test abilities for not connected user' do
    ability = Ability.new(User.new)
    assert ability.cannot?(:create, Blog.new), 'should not be able to create'
    assert ability.can?(:read, @blog), 'should be able to read'
    assert ability.cannot?(:update, @blog), 'should not be able to update'
    assert ability.cannot?(:destroy, @blog), 'should not be able to destroy'
  end

  test 'should test abilities for connected user' do
    ability = Ability.new(@user)
    assert ability.can?(:create, Blog.new), 'should be able to create'
    assert ability.can?(:read, @blog), 'should be able to read'
    assert ability.can?(:update, @blog), 'should be able to update'
    assert ability.can?(:destroy, @blog), 'should be able to destroy'
  end

  test 'should not have abilities to manage other users blog posts' do
    ability = Ability.new(@user2)
    assert ability.can?(:create, Blog.new), 'should be able to create'
    assert ability.can?(:read, @blog), 'should be able to read'
    assert ability.cannot?(:update, @blog), 'should not be able to update'
    assert ability.cannot?(:destroy, @blog), 'should not be able to destroy'
  end
end
