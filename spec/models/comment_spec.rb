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

  describe 'abilities' do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }
    let(:comment) { create(:comment, user: user) }

    context 'when is not connected' do
      let(:comment) { create(:comment, user: create(:user)) }

      it { should_not be_able_to(:create, Comment.new) }
      it { should be_able_to(:read, comment) }
      it { should_not be_able_to(:update, comment) }
      it { should_not be_able_to(:destroy, comment) }
    end

    context 'when is an author' do
      let(:user) { create(:user, :author) }

      context 'when he is the owner' do
        it { should be_able_to(:create, Comment.new) }
        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should be_able_to(:destroy, comment) }
      end

      context 'when he is not the owner' do
        let(:user2) { create(:user, :author) }
        let(:comment) { create(:comment, user: user2) }

        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should_not be_able_to(:destroy, comment) }
      end
    end

    context 'when is an admin' do
      let(:user) { create(:user, :admin) }

      context 'when he is the owner' do
        it { should be_able_to(:create, Comment.new) }
        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should be_able_to(:destroy, comment) }
      end

      context 'when owner is a master' do
        let(:user2) { create(:user, :master) }
        let(:comment) { create(:comment, user: user2) }

        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should_not be_able_to(:destroy, comment) }
      end

      context 'when owner is another admin' do
        let(:user2) { create(:user, :admin) }
        let(:comment) { create(:comment, user: user2) }

        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should_not be_able_to(:destroy, comment) }
      end

      context 'when owner is an author' do
        let(:user2) { create(:user, :author) }
        let(:comment2) { create(:comment, user: user2) }

        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should be_able_to(:destroy, comment) }
      end
    end

    context 'when is a master' do
      let(:user) { create(:user, :master) }
      context 'when he is the owner' do
        it { should be_able_to(:create, Comment.new) }
        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should be_able_to(:destroy, comment) }
      end

      context 'when owner is another master' do
        let(:user2) { create(:user, :master) }
        let(:comment) { create(:comment, user: user2) }

        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should_not be_able_to(:destroy, comment) }
      end

      context 'when owner is an admin' do
        let(:user2) { create(:user, :admin) }
        let(:comment2) { create(:comment, user: user2) }

        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should be_able_to(:destroy, comment) }
      end

      context 'when owner is an author' do
        let(:user2) { create(:user, :author) }
        let(:comment) { create(:comment, user: user2) }

        it { should be_able_to(:read, comment) }
        it { should_not be_able_to(:update, comment) }
        it { should be_able_to(:destroy, comment) }
      end
    end
  end
end
