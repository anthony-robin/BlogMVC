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

  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context 'when is not connected' do
      it { should_not be_able_to(:create, Blog.new) }
      it { should be_able_to(:read, create(:blog)) }
      it { should_not be_able_to(:update, create(:blog)) }
      it { should_not be_able_to(:destroy, create(:blog)) }
    end

    context 'when is an author' do
      let(:user) { create(:user, :author) }
      context 'when he is the owner' do
        it { should be_able_to(:create, Blog.new) }
        it { should be_able_to(:read, create(:blog, user: user)) }
        it { should be_able_to(:update, create(:blog, user: user)) }
        it { should be_able_to(:destroy, create(:blog, user: user)) }
      end

      context 'when he is not the owner' do
        let(:user2) { create(:user, :author) }
        let(:blog2) { create(:blog, user: user2) }
        it { should be_able_to(:read, blog2) }
        it { should_not be_able_to(:update, blog2) }
        it { should_not be_able_to(:destroy, blog2) }
      end
    end

    context 'when is an admin' do
      let(:user) { create(:user, :admin) }
      context 'when he is the owner' do
        it { should be_able_to(:create, Blog.new) }
        it { should be_able_to(:read, create(:blog, user: user)) }
        it { should be_able_to(:update, create(:blog, user: user)) }
        it { should be_able_to(:destroy, create(:blog, user: user)) }
      end

      context 'when owner is a master' do
        let(:user2) { create(:user, :master) }
        let(:blog2) { create(:blog, user: user2) }
        it { should be_able_to(:read, blog2) }
        it { should_not be_able_to(:update, blog2) }
        it { should_not be_able_to(:destroy, blog2) }
      end

      context 'when owner is another admin' do
        let(:user2) { create(:user, :admin) }
        let(:blog2) { create(:blog, user: user2) }
        it { should be_able_to(:read, blog2) }
        it { should_not be_able_to(:update, blog2) }
        it { should_not be_able_to(:destroy, blog2) }
      end

      context 'when owner is an author' do
        let(:user2) { create(:user, :author) }
        let(:blog2) { create(:blog, user: user2) }
        it { should be_able_to(:read, blog2) }
        it { should be_able_to(:update, blog2) }
        it { should be_able_to(:destroy, blog2) }
      end
    end

    context 'when is a master' do
      let(:user) { create(:user, :master) }
      context 'when he is the owner' do
        it { should be_able_to(:create, Blog.new) }
        it { should be_able_to(:read, user) }
        it { should be_able_to(:update, user) }
        it { should be_able_to(:destroy, user) }
      end

      context 'when owner is another master' do
        let(:user2) { create(:user, :master) }
        let(:blog2) { create(:blog, user: user2) }
        it { should be_able_to(:read, blog2) }
        it { should_not be_able_to(:update, blog2) }
        it { should_not be_able_to(:destroy, blog2) }
      end

      context 'when owner is an admin' do
        let(:user2) { create(:user, :admin) }
        let(:blog2) { create(:blog, user: user2) }
        it { should be_able_to(:read, blog2) }
        it { should be_able_to(:update, blog2) }
        it { should be_able_to(:destroy, blog2) }
      end

      context 'when owner is an author' do
        let(:user2) { create(:user, :author) }
        let(:blog2) { create(:blog, user: user2) }
        it { should be_able_to(:read, blog2) }
        it { should be_able_to(:update, blog2) }
        it { should be_able_to(:destroy, blog2) }
      end
    end
  end
end
