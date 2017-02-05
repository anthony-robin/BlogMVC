require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # Model relations
  should belong_to(:category)

  # Presence
  should validate_presence_of(:title)
  should validate_presence_of(:content)
  should validate_presence_of(:category_id)

  # Inclusion
  should validate_inclusion_of(:category_id)
    .in_array(Category.all.map(&:id))
  should_not validate_inclusion_of(:category_id)
    .in_array([30, 999, 7532])

  # Values
  should allow_value('Lorem ipsum dolor sit amet').for(:title)
  should allow_value('<p>Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>').for(:content)

  # Delegates
  should delegate_method(:name).to(:category).with_prefix
  should delegate_method(:username).to(:user).with_prefix
  should delegate_method(:role).to(:user).with_prefix

  context 'A blog' do
    # --------------
    # Create
    # --------------
    context 'on create' do
      should 'have an auto slug' do
        blog = Blog.create(title: 'Premier titre')
        assert_equal 'premier-titre', blog.slug
      end

      should 'increase counter cache' do
        reset_counter_cache
        category = categories(:one)
        author = users(:author)

        assert_equal 2, category.blogs_count
        assert_equal 1, author.blogs_count

        Blog.create(
          title: 'Lorem ipsum counter cache',
          content: '<p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
          category_id: category.id,
          user_id: author.id
        )
        assert_equal 3, category.reload.blogs_count
        assert_equal 2, author.reload.blogs_count
      end
    end

    # --------------
    # Update
    # --------------
    context 'on update' do
      should 'have a new generated slug' do
        blog = blogs(:one)
        blog.update_attributes(title: 'Nouveau titre')
        assert_equal 'nouveau-titre', blog.slug
      end
    end

    # --------------
    # Destroy
    # --------------
    context 'on destroy' do
      should 'decrease counter cache' do
        reset_counter_cache
        category = categories(:one)
        author = users(:author)

        assert_equal 2, category.blogs_count
        assert_equal 1, author.blogs_count

        category.blogs.map(&:destroy)
        assert_equal 0, category.reload.blogs_count
        assert_equal 0, author.reload.blogs_count
      end
    end
  end

  private

  def reset_counter_cache
    Category.reset_column_information
    Category.all.each do |p|
      Category.update_counters p.id, blogs_count: 0
    end
  end
end
