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

  # Slug
  test 'should create slug on blog create' do
    blog = Blog.create(
      title: 'Premier titre'
    )
    assert_equal 'premier-titre', blog.slug
  end

  test 'should update slug on blog update' do
    blog = blogs(:one)
    blog.update_attributes(title: 'Nouveau titre')
    assert_equal 'nouveau-titre', blog.slug
  end

  # Counter cache
  test 'should increase counter cache when creating object' do
    reset_counter_cache

    category = categories(:one)
    assert_equal 2, category.blogs_count

    Blog.create(
      title: 'Lorem ipsum counter cache',
      content: '<p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>',
      category_id: category.id
    )

    assert_equal 3, category.reload.blogs_count
  end

  test 'should decrease counter cache when destroying object' do
    reset_counter_cache

    category = categories(:one)
    assert_equal 2, category.blogs_count

    category.blogs.map(&:destroy)
    assert_equal 0, category.blogs_count
  end

  private

  def reset_counter_cache
    Category.reset_column_information
    Category.all.each do |p|
      Category.update_counters p.id, blogs_count: p.blogs.count
    end
  end
end
