require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = blogs(:one)
  end

  test "should get index" do
    get blogs_url
    assert_response :success
  end

  test "should get new" do
    get new_blog_url
    assert_response :success
  end

  test "should create blog" do
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

  test "should show blog" do
    get category_blog_url(@blog.category, @blog)
    assert_response :success
  end

  test "should get edit" do
    get edit_category_blog_url(@blog.category, @blog)
    assert_response :success
  end

  test "should update blog" do
    blog = {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: @blog.category.id
    }
    patch blog_url(@blog), params: { blog: blog }
    @blog.reload
    assert_redirected_to category_blog_url(@blog.category, @blog)
  end

  test "should destroy blog" do
    assert_difference('Blog.count', -1) do
      delete blog_url(@blog)
    end

    assert_redirected_to blogs_url
  end
end
