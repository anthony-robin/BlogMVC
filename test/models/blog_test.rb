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
end
