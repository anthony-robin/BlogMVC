require 'rails_helper'

RSpec.describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { described_class.new(user, :avatar) }

  before do
    described_class.enable_processing = true
    path_to_file = Rails.root.join('spec', 'fixtures', 'avatar.png')
    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  context 'the small version' do
    it 'scales down avatar to fill within 100 by 100 pixels' do
      expect(uploader.small).to have_dimensions(100, 100)
    end

    it 'scales down avatar to fill within 200 by 200 pixels (retina)' do
      expect(uploader.small_2x).to have_dimensions(200, 200)
    end
  end

  context 'the large version' do
    it 'scales down avatar to fill within 200 by 200 pixels' do
      expect(uploader.large).to have_dimensions(200, 200)
    end

    it 'scales down avatar to fill within 400 by 400 pixels (retina)' do
      expect(uploader.large_2x).to have_dimensions(400, 400)
    end
  end

  it 'makes the image readable only to the owner and not executable' do
    expect(uploader).to have_permissions(0644)
  end

  it 'has the correct format' do
    expect(uploader).to be_format('png')
  end

  it 'has correct extension_whitelist' do
    whitelist = %w[jpg jpeg png]
    expect(uploader.extension_whitelist).to eq(whitelist)
  end

  it 'has correct filename' do
    filename = 'avatar.jpg'
    expect(uploader.filename).to eq(filename)
  end
end
