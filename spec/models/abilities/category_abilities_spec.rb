require 'rails_helper'

RSpec.describe 'Category::Ability' do
  let(:user) { nil }
  let(:category) { create(:category) }
  subject(:ability) { Ability.new(user) }

  context 'when is not connected' do
    it { should_not be_able_to(:create, Category.new) }
    it { should_not be_able_to(:read, category) }
    it { should_not be_able_to(:update, category) }
    it { should_not be_able_to(:destroy, category) }
  end

  context 'when is an author' do
    let(:user) { create(:user, :author) }
    it { should_not be_able_to(:create, Category.new) }
    it { should_not be_able_to(:read, category) }
    it { should_not be_able_to(:update, category) }
    it { should_not be_able_to(:destroy, category) }
  end

  context 'when is an admin' do
    let(:user) { create(:user, :admin) }
    it { should be_able_to(:create, Category.new) }
    it { should be_able_to(:read, category) }
    it { should be_able_to(:update, category) }
    it { should be_able_to(:destroy, category) }
  end

  context 'when is a master' do
    let(:user) { create(:user, :master) }
    it { should be_able_to(:create, Category.new) }
    it { should be_able_to(:read, category) }
    it { should be_able_to(:update, category) }
    it { should be_able_to(:destroy, category) }
  end
end
