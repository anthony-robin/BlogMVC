require 'rails_helper'

RSpec.describe Comment do
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:commentable) }
  end

  context 'a comment' do
    let(:user) { create(:user) }
    let(:blog) { create(:blog) }
    let(:comment) { build(:comment, commentable: blog, user: user, body: 'Lorem ispum !') }

    context 'on CREATE' do
      it('is valid') { expect(comment).to be_valid }
      it('has no errors') { expect(comment.errors).to be_empty }
      it 'increases counter cache' do
        expect(blog.comments_count).to eq(0)
        expect(user.comments_count).to eq(0)
        comment.save!
        expect(blog.comments_count).to eq(1)
        expect(user.comments_count).to eq(1)
      end
    end

    context 'on DESTROY' do
      it 'decreases counter cache' do
        comment.save!
        expect(blog.comments_count).to eq(1)
        expect(user.comments_count).to eq(1)
        comment.destroy!
        expect(blog.reload.comments_count).to eq(0)
        expect(user.reload.comments_count).to eq(0)
      end
    end
  end
end
