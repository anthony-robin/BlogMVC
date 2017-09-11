require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to have_many(:blogs) }
  end

  describe 'validations rules' do
    describe 'enum' do
      it { is_expected.to define_enum_for(:role).with(described_class.roles.keys) }
    end
  end
end
