require 'rails_helper'

describe 'User::Ability' do
  let(:user) { nil }
  subject(:ability) { Ability.new(user) }

  context 'when is not connected' do
    it { should_not be_able_to(:create, User.new) }
    it { should be_able_to(:read, create(:user, :author)) }
    it { should_not be_able_to(:update, create(:user, :author)) }
    it { should_not be_able_to(:destroy, create(:user, :author)) }
  end

  context 'when is an author' do
    let(:user) { create(:user, :author) }
    it { should_not be_able_to(:create, User.new) }
    it { should be_able_to(:read, user) }
    it { should be_able_to(:update, user) }
    it { should be_able_to(:destroy, user) }
  end

  context 'when is an admin' do
    let(:user) { create(:user, :admin) }
    it { should_not be_able_to(:create, User.new) }
    it { should be_able_to(:read, user) }
    it { should be_able_to(:update, user) }
    it { should be_able_to(:destroy, user) }
  end

  context 'when is a master' do
    let(:user) { create(:user, :master) }
    it { should be_able_to(:create, User.new) }
    it { should be_able_to(:read, user) }
    it { should be_able_to(:update, user) }
    it { should be_able_to(:destroy, user) }
  end

  context 'user can only manage own profile' do
    let(:user) { create(:user, :admin) }
    let(:user2) { create(:user, :author) }
    it { should_not be_able_to(:create, User.new) }
    it { should be_able_to(:read, user2) }
    it { should_not be_able_to(:update, user2) }
    it { should_not be_able_to(:destroy, user2) }
  end
end
