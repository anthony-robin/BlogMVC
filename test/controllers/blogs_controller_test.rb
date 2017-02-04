require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = blogs(:one)
    sign_in users(:one)
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
    blog = {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: @blog.category.id
    }
    sign_out_and_ensure_redirect_to_sign_in do
      patch blog_url(@blog), params: { blog: blog }
    end
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
end
