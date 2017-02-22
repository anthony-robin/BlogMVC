require 'rails_helper'

RSpec.describe Picture, type: :model do
  context 'associations' do
    it { should belong_to(:attachable) }
  end
end
