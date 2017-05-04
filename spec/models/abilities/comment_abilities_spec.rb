require 'rails_helper'

describe 'Comment::Ability' do
  let(:user) { nil }
  let(:comment) { create(:comment, user: user) }
  subject(:ability) { Ability.new(user) }

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
