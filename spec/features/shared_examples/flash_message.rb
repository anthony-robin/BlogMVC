RSpec.shared_examples_for :flash_message do
  before { subject }

  it 'has correct message' do
    expect(flash[flash_type]).to eq flash_message
  end
end
