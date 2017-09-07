require 'rails_helper'

RSpec.describe User do
  subject(:ability) { Ability.new(user) }

  let(:user) { nil }

  context 'when is not connected' do
    it { is_expected.to_not be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, create(:user, :author)) }
    it { is_expected.to_not be_able_to(:update, create(:user, :author)) }
    it { is_expected.to_not be_able_to(:destroy, create(:user, :author)) }
  end

  context 'when is an author' do
    let(:user) { create(:user, :author) }

    it { is_expected.to_not be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, user) }
    it { is_expected.to be_able_to(:update, user) }
    it { is_expected.to be_able_to(:destroy, user) }
  end

  context 'when is an admin' do
    let(:user) { create(:user, :admin) }

    it { is_expected.to_not be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, user) }
    it { is_expected.to be_able_to(:update, user) }
    it { is_expected.to be_able_to(:destroy, user) }
  end

  context 'when is a master' do
    let(:user) { create(:user, :master) }

    it { is_expected.to be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, user) }
    it { is_expected.to be_able_to(:update, user) }
    it { is_expected.to be_able_to(:destroy, user) }
  end

  context 'user can only manage own profile' do
    let(:user) { create(:user, :admin) }
    let(:user2) { create(:user, :author) }

    it { is_expected.to_not be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, user2) }
    it { is_expected.to_not be_able_to(:update, user2) }
    it { is_expected.to_not be_able_to(:destroy, user2) }
  end
end
