require 'rails_helper'

RSpec.describe Comment do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:commentable) }

  describe 'a comment' do
    let(:user) { create(:user) }
    let(:blog) { create(:blog) }
    let(:comment) { build(:comment, commentable: blog, user: user, body: 'Lorem ispum !') }

    describe 'on CREATE' do
      before { comment.save! }

      it('is valid') { expect(comment).to be_valid }
      it('has no errors') { expect(comment.errors).to be_empty }

      it 'increases blogs counter cache' do
        expect(blog.comments_count).to eq(1)
      end

      it 'increases user counter cache' do
        expect(user.comments_count).to eq(1)
      end
    end

    describe 'on DESTROY' do
      before do
        comment.save!
        comment.destroy!
      end

      it 'decreases blogs counter cache' do
        expect(blog.reload.comments_count).to eq(0)
      end

      it 'decreases user counter cache' do
        expect(user.reload.comments_count).to eq(0)
      end
    end
  end
end
