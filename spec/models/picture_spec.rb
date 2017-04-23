require 'rails_helper'

describe Picture do
  context 'associations' do
    it { should belong_to(:attachable) }
  end
end
