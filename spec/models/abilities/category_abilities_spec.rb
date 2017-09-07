require 'rails_helper'

RSpec.describe Category do
  subject(:ability) { Ability.new(user) }

  let(:user) { nil }
  let(:category) { create(:category) }

  context 'when is not connected' do
    it { is_expected.to_not be_able_to(:create, described_class.new) }
    it { is_expected.to_not be_able_to(:read, category) }
    it { is_expected.to_not be_able_to(:update, category) }
    it { is_expected.to_not be_able_to(:destroy, category) }
  end

  context 'when is an author' do
    let(:user) { create(:user, :author) }

    it { is_expected.to_not be_able_to(:create, described_class.new) }
    it { is_expected.to_not be_able_to(:read, category) }
    it { is_expected.to_not be_able_to(:update, category) }
    it { is_expected.to_not be_able_to(:destroy, category) }
  end

  context 'when is an admin' do
    let(:user) { create(:user, :admin) }

    it { is_expected.to be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, category) }
    it { is_expected.to be_able_to(:update, category) }
    it { is_expected.to be_able_to(:destroy, category) }
  end

  context 'when is a master' do
    let(:user) { create(:user, :master) }

    it { is_expected.to be_able_to(:create, described_class.new) }
    it { is_expected.to be_able_to(:read, category) }
    it { is_expected.to be_able_to(:update, category) }
    it { is_expected.to be_able_to(:destroy, category) }
  end
end
