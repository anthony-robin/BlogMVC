require 'rails_helper'

describe Picture do
  context 'associations' do
    it { is_expected.to belong_to(:attachable) }
  end
end
