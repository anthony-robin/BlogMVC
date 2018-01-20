require 'rails_helper'

RSpec.describe Picture do
  it { is_expected.to belong_to(:attachable) }
end
