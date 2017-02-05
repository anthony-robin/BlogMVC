require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blog = blogs(:one)
    @master = users(:master)
    @admin = users(:admin)
    @author = users(:author)
  end

  # --------------
  # Everyone
  # --------------
  context 'Everyone' do
    should 'get index' do
      get blogs_url
      assert_response :success
    end

    should 'show blog' do
      get category_blog_url(@blog.category, @blog)
      assert_response :success
    end
  end

  # --------------
  # Non connected
  # --------------
  context 'A non connected user' do
    setup do
      @blog = blogs(:one)
    end

    should 'not get new' do
      sign_out_and_ensure_redirect_to_sign_in do
        get new_blog_url
      end
    end

    should 'not create blog' do
      sign_out_and_ensure_redirect_to_sign_in do
        assert_no_difference('Blog.count') do
          post blogs_url, params: { blog: valid_blog_params }
        end
      end
    end

    should 'not get edit' do
      sign_out_and_ensure_redirect_to_sign_in do
        get edit_category_blog_url(@blog.category, @blog)
      end
    end

    should 'not update blog' do
      sign_out_and_ensure_redirect_to_sign_in do
        patch blog_url(@blog), params: { blog: {} }
      end
    end

    should 'not destroy blog' do
      sign_out_and_ensure_redirect_to_sign_in do
        assert_no_difference('Blog.count') do
          delete blog_url(@blog)
        end
      end
    end

    should 'test abilities for not connected user' do
      ability = Ability.new(User.new)
      assert ability.cannot?(:create, Blog.new), 'should not be able to create'
      assert ability.can?(:read, @blog), 'should be able to read'
      assert ability.cannot?(:update, @blog), 'should not be able to update'
      assert ability.cannot?(:destroy, @blog), 'should not be able to destroy'
    end
  end

  # --------------
  # Author
  # --------------
  context 'An author' do
    setup do
      @blog = blogs(:four)
      sign_in @author
    end

    should 'get new' do
      get new_blog_url
      assert_response :success
    end

    should 'create blog' do
      assert_difference('Blog.count') do
        post blogs_url, params: { blog: valid_blog_params }
      end
      last_blog = Blog.last
      assert_redirected_to category_blog_url(last_blog.category, last_blog)
    end

    should 'get edit' do
      get edit_category_blog_url(@blog.category, @blog)
      assert_response :success
    end

    should 'update blog' do
      patch blog_url(@blog), params: { blog: valid_blog_params }
      @blog.reload
      assert_redirected_to category_blog_url(@blog.category, @blog)
    end

    should 'destroy blog' do
      assert_difference('Blog.count', -1) do
        delete blog_url(@blog)
      end
      assert_redirected_to blogs_url
    end

    should 'test abilities for author role' do
      ability = Ability.new(@author)
      assert ability.can?(:create, Blog.new), 'should be able to create'
      assert ability.can?(:read, @blog), 'should be able to read'
      assert ability.can?(:update, @blog), 'should be able to update'
      assert ability.can?(:destroy, @blog), 'should be able to destroy'
    end
  end

  # --------------
  # Admin
  # --------------
  context 'An admin' do
    setup do
      @blog = blogs(:three)
      sign_in @admin
    end

    should 'get new' do
      get new_blog_url
      assert_response :success
    end

    should 'create blog' do
      assert_difference('Blog.count') do
        post blogs_url, params: { blog: valid_blog_params }
      end
      last_blog = Blog.last
      assert_redirected_to category_blog_url(last_blog.category, last_blog)
    end

    should 'get edit' do
      get edit_category_blog_url(@blog.category, @blog)
      assert_response :success
    end

    should 'update blog' do
      patch blog_url(@blog), params: { blog: valid_blog_params }
      @blog.reload
      assert_redirected_to category_blog_url(@blog.category, @blog)
    end

    should 'destroy blog' do
      assert_difference('Blog.count', -1) do
        delete blog_url(@blog)
      end
      assert_redirected_to blogs_url
    end

    should 'test abilities for admin role' do
      ability = Ability.new(@admin)
      assert ability.can?(:create, Blog.new), 'should be able to create'
      assert ability.can?(:read, @blog), 'should be able to read'
      assert ability.can?(:update, @blog), 'should be able to update'
      assert ability.can?(:destroy, @blog), 'should be able to destroy'
    end
  end

  # --------------
  # Master
  # --------------
  context 'A master' do
    setup do
      sign_in @master
    end

    should 'get new' do
      get new_blog_url
      assert_response :success
    end

    should 'create blog' do
      assert_difference('Blog.count') do
        post blogs_url, params: { blog: valid_blog_params }
      end
      last_blog = Blog.last
      assert_redirected_to category_blog_url(last_blog.category, last_blog)
    end

    should 'get edit' do
      get edit_category_blog_url(@blog.category, @blog)
      assert_response :success
    end

    should 'update blog' do
      patch blog_url(@blog), params: { blog: valid_blog_params }
      @blog.reload
      assert_redirected_to category_blog_url(@blog.category, @blog)
    end

    should 'destroy blog' do
      assert_difference('Blog.count', -1) do
        delete blog_url(@blog)
      end
      assert_redirected_to blogs_url
    end

    should 'test abilities for master role' do
      ability = Ability.new(@master)
      assert ability.can?(:create, Blog.new), 'should be able to create'
      assert ability.can?(:read, @blog), 'should be able to read'
      assert ability.can?(:update, @blog), 'should be able to update'
      assert ability.can?(:destroy, @blog), 'should be able to destroy'
    end
  end

  should 'not get edit from another user' do
    sign_in @admin
    get edit_category_blog_url(@blog.category, @blog)
    assert_redirected_to root_url
    assert_not flash[:alert].empty?
    assert_equal I18n.t('unauthorized.update.blog'), flash[:alert]
  end

  should 'not update blog from another user' do
    sign_in @admin
    patch blog_url(@blog), params: { blog: {} }
    assert_redirected_to root_url
    assert_not flash[:alert].empty?
    assert_equal I18n.t('unauthorized.update.blog'), flash[:alert]
  end

  should 'not destroy blog from another user' do
    sign_in @admin
    delete blog_url(@blog)
    assert_redirected_to root_url
    assert_not flash[:alert].empty?
    assert_equal I18n.t('unauthorized.destroy.blog'), flash[:alert]
  end

  should 'have correct owner for blog article' do
    post blogs_url, params: { blog: valid_blog_params }
    assert_equal @master, Blog.last.user
  end

  # --------------
  # Abilities
  # --------------
  should 'not have abilities to manage other users blog posts' do
    ability = Ability.new(@admin)
    assert ability.can?(:create, Blog.new), 'should be able to create'
    assert ability.can?(:read, @blog), 'should be able to read'
    assert ability.cannot?(:update, @blog), 'should not be able to update'
    assert ability.cannot?(:destroy, @blog), 'should not be able to destroy'
  end

  private

  def valid_blog_params
    {
      title: 'Article example',
      content: 'Lorem ipsum dolor sit amet',
      category_id: Category.first.id
    }
  end
end
