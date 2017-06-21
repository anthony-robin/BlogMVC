require 'rails_helper'

RSpec.describe Blog do
  context 'associations' do
    it { is_expected.to belong_to(:category) }
  end

  context 'delegates' do
    it { is_expected.to delegate_method(:name).to(:category).with_prefix }
    it { is_expected.to delegate_method(:username).to(:user).with_prefix }
    it { is_expected.to delegate_method(:role).to(:user).with_prefix }
  end

  context 'a blog' do
    context 'on CREATE' do
      let(:blog) { build(:blog, title: 'First blog article') }

      it 'has an auto slug' do
        blog.save!
        expect(blog.slug).to eq('first-blog-article')
      end

      it 'increases counter cache' do
        expect(blog.category.blogs_count).to eq(0)
        expect(blog.user.blogs_count).to eq(0)
        blog.save!
        expect(blog.category.blogs_count).to eq(1)
        expect(blog.user.blogs_count).to eq(1)
      end
    end

    context 'on UPDATE' do
      let(:blog) { create(:blog) }

      it 'has a new slug' do
        blog.update_attributes(title: 'First blog article with update')
        expect(blog.slug).to eq('first-blog-article-with-update')
      end
    end

    context 'on DESTROY' do
      let(:blog) { create(:blog) }

      it 'decreases counter cache' do
        expect(blog.category.blogs_count).to eq(1)
        expect(blog.user.blogs_count).to eq(1)
        blog.destroy
        expect(blog.category.blogs_count).to eq(0)
        expect(blog.user.blogs_count).to eq(0)
      end
    end
  end
end
