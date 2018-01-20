require 'rails_helper'

RSpec.describe Blog do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to delegate_method(:name).to(:category).with_prefix }
  it { is_expected.to delegate_method(:username).to(:user).with_prefix }
  it { is_expected.to delegate_method(:role).to(:user).with_prefix }

  describe 'a blog' do
    describe 'on CREATE' do
      let(:blog) { build(:blog, title: 'First blog article') }

      before { blog.save! }

      it 'has an auto slug' do
        expect(blog.slug).to eq('first-blog-article')
      end

      it 'increases category blogs counter cache' do
        expect(blog.category.blogs_count).to eq(1)
      end

      it 'increases user blogs counter cache' do
        expect(blog.user.blogs_count).to eq(1)
      end
    end

    describe 'on UPDATE' do
      let(:blog) { create(:blog) }

      it 'has a new slug' do
        blog.update_attributes!(title: 'First blog article with update')
        expect(blog.slug).to eq('first-blog-article-with-update')
      end
    end

    describe 'on DESTROY' do
      let(:blog) { create(:blog) }

      before { blog.destroy! }

      it 'decreases category blogs counter cache' do
        expect(blog.category.blogs_count).to eq(0)
      end

      it 'decreases user blogs counter cache' do
        expect(blog.user.blogs_count).to eq(0)
      end
    end
  end
end
