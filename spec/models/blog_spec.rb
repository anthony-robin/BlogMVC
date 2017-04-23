require 'rails_helper'

describe Blog do
  context 'associations' do
    it { should belong_to(:category) }
  end

  context 'delegates' do
    it { should delegate_method(:name).to(:category).with_prefix }
    it { should delegate_method(:username).to(:user).with_prefix }
    it { should delegate_method(:role).to(:user).with_prefix }
  end

  context 'validations rules' do
    context 'presence' do
      it { should validate_presence_of(:title) }
      it { should validate_presence_of(:content) }
      it { should validate_presence_of(:category_id) }
    end

    context 'format' do
      it { should allow_value('Lorem ipsum dolor sit amet').for(:title) }
      it { should allow_value('<p>Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>').for(:content) }
    end

    context 'inclusion' do
      it { should validate_inclusion_of(:category_id).in_array(Category.all.map(&:id)) }
      it { should_not validate_inclusion_of(:category_id).in_array([30, 999, 7532]) }
    end
  end

  context 'a blog' do
    context 'on CREATE' do
      let(:blog) { build(:blog, title: 'First blog article') }
      it('should be valid') { expect(blog).to be_valid }
      it('should not have errors') { expect(blog.errors).to be_empty }
      it('should have an auto slug') do
        blog.save!
        expect(blog.slug).to eq('first-blog-article')
      end

      it 'sould increase counter cache' do
        expect(blog.category.blogs_count).to eq(0)
        expect(blog.user.blogs_count).to eq(0)
        blog.save!
        expect(blog.category.blogs_count).to eq(1)
        expect(blog.user.blogs_count).to eq(1)
      end
    end

    context 'on UPDATE' do
      let(:blog) { create(:blog) }
      it('should have a new generated slug') do
        blog.update_attributes(title: 'First blog article with update')
        expect(blog.slug).to eq('first-blog-article-with-update')
      end
    end

    context 'on DESTROY' do
      let(:blog) { create(:blog) }
      it 'sould decrease counter cache' do
        expect(blog.category.blogs_count).to eq(1)
        expect(blog.user.blogs_count).to eq(1)
        blog.destroy
        expect(blog.category.blogs_count).to eq(0)
        expect(blog.user.blogs_count).to eq(0)
      end
    end
  end
end
