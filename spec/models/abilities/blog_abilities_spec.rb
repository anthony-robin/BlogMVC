require 'rails_helper'

RSpec.describe Blog do
  subject { Ability.new(user) }

  let(:user) { nil }

  context 'when is not connected' do
    it { is_expected.to_not be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, create(:blog)) }
    it { is_expected.to_not be_able_to(:update, create(:blog)) }
    it { is_expected.to_not be_able_to(:destroy, create(:blog)) }
  end

  context 'when is an author' do
    let(:user) { create(:user, :author) }

    context 'when he is the owner' do
      it { is_expected.to be_able_to(:create, described_class.new) }
      it { is_expected.to be_able_to(:read, create(:blog, user: user)) }
      it { is_expected.to be_able_to(:update, create(:blog, user: user)) }
      it { is_expected.to be_able_to(:destroy, create(:blog, user: user)) }
    end

    context 'when he is not the owner' do
      let(:user2) { create(:user, :author) }
      let(:blog2) { create(:blog, user: user2) }

      it { is_expected.to be_able_to(:read, blog2) }
      it { is_expected.to_not be_able_to(:update, blog2) }
      it { is_expected.to_not be_able_to(:destroy, blog2) }
    end
  end

  context 'when is an admin' do
    let(:user) { create(:user, :admin) }

    context 'when he is the owner' do
      let(:blog) { create(:blog, user: user) }

      it { is_expected.to be_able_to(:create, described_class.new) }
      it { is_expected.to be_able_to(:read, blog) }
      it { is_expected.to be_able_to(:update, blog) }
      it { is_expected.to be_able_to(:destroy, blog) }
    end

    context 'when owner is a master' do
      let(:user2) { create(:user, :master) }
      let(:blog2) { create(:blog, user: user2) }

      it { is_expected.to be_able_to(:read, blog2) }
      it { is_expected.to_not be_able_to(:update, blog2) }
      it { is_expected.to_not be_able_to(:destroy, blog2) }
    end

    context 'when owner is another admin' do
      let(:user2) { create(:user, :admin) }
      let(:blog2) { create(:blog, user: user2) }

      it { is_expected.to be_able_to(:read, blog2) }
      it { is_expected.to_not be_able_to(:update, blog2) }
      it { is_expected.to_not be_able_to(:destroy, blog2) }
    end

    context 'when owner is an author' do
      let(:user2) { create(:user, :author) }
      let(:blog2) { create(:blog, user: user2) }

      it { is_expected.to be_able_to(:read, blog2) }
      it { is_expected.to be_able_to(:update, blog2) }
      it { is_expected.to be_able_to(:destroy, blog2) }
    end
  end

  context 'when is a master' do
    let(:user) { create(:user, :master) }

    context 'when he is the owner' do
      it { is_expected.to be_able_to(:create, described_class.new) }
      it { is_expected.to be_able_to(:read, user) }
      it { is_expected.to be_able_to(:update, user) }
      it { is_expected.to be_able_to(:destroy, user) }
    end

    context 'when owner is another master' do
      let(:user2) { create(:user, :master) }
      let(:blog2) { create(:blog, user: user2) }

      it { is_expected.to be_able_to(:read, blog2) }
      it { is_expected.to_not be_able_to(:update, blog2) }
      it { is_expected.to_not be_able_to(:destroy, blog2) }
    end

    context 'when owner is an admin' do
      let(:user2) { create(:user, :admin) }
      let(:blog2) { create(:blog, user: user2) }

      it { is_expected.to be_able_to(:read, blog2) }
      it { is_expected.to be_able_to(:update, blog2) }
      it { is_expected.to be_able_to(:destroy, blog2) }
    end

    context 'when owner is an author' do
      let(:user2) { create(:user, :author) }
      let(:blog2) { create(:blog, user: user2) }

      it { is_expected.to be_able_to(:read, blog2) }
      it { is_expected.to be_able_to(:update, blog2) }
      it { is_expected.to be_able_to(:destroy, blog2) }
    end
  end
end
