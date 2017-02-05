require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Model relations
  should have_many(:blogs)

  # Uniqueness
  should validate_presence_of(:name)
  should validate_uniqueness_of(:name)

  # Values
  should allow_value('Foo2').for(:name)
  should_not allow_value('Foo').for(:name)

  context 'A category' do
    # --------------
    # Create
    # --------------
    context 'on create' do
      should 'have an auto slug' do
        category = Category.create(name: 'Première catégorie')
        assert_equal 'premiere-categorie', category.slug
      end
    end

    # --------------
    # Update
    # --------------
    context 'on update' do
      should 'have a new generated slug' do
        category = categories(:one)
        category.update_attributes(name: 'Ma catégorie modifiée')
        assert_equal 'ma-categorie-modifiee', category.slug
      end
    end
  end
end
