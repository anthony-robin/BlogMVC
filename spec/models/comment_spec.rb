require 'rails_helper'

describe Comment do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
  end

  context 'validations rules' do
    context 'presence' do
      it { should validate_presence_of(:body) }
      it { should validate_presence_of(:user) }
      it { should validate_absence_of(:nickname) }
    end

    context 'format' do
      it { should allow_value('Lorem ipsum dolor sit amet').for(:body) }
    end
  end

  context 'a comment' do
    let(:user) { create(:user) }
    let(:blog) { create(:blog) }
    let(:comment) { build(:comment, commentable: blog, user: user, body: 'Lorem ispum !') }

    context 'on CREATE' do
      it('should be valid') { expect(comment).to be_valid }
      it('should not have errors') { expect(comment.errors).to be_empty }
      it 'should increase counter cache' do
        expect(blog.comments_count).to eq(0)
        expect(user.comments_count).to eq(0)
        comment.save!
        expect(blog.comments_count).to eq(1)
        expect(user.comments_count).to eq(1)
      end
    end

    context 'on DESTROY' do
      it 'should decrease counter cache' do
        comment.save!
        expect(blog.comments_count).to eq(1)
        expect(user.comments_count).to eq(1)
        comment.destroy
        expect(blog.reload.comments_count).to eq(0)
        expect(user.reload.comments_count).to eq(0)
      end
    end
  end
end
