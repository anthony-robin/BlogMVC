require 'rails_helper'

describe ImageUploader do
  include CarrierWave::Test::Matchers

  let(:picture) { create(:picture, :for_blog) }
  let(:uploader) { ImageUploader.new(picture, :image) }

  before do
    ImageUploader.enable_processing = true
    path_to_file = Rails.root.join('spec', 'fixtures', 'picture.png')
    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    ImageUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it 'scales down a landscape image to be exactly 50 by 50 pixels (x2 for retina display)' do
      expect(uploader.thumb).to have_dimensions(50 * 2, 50 * 2)
    end
  end

  context 'the small version' do
    it 'scales down a landscape image to fit within 100 by 100 pixels (x2 for retina display)' do
      expect(uploader.small).to have_dimensions(100 * 2, 100 * 2)
    end
  end

  context 'the medium version' do
    it 'scales down a landscape image to fit within 256 by 256 pixels (x2 for retina display)' do
      expect(uploader.medium).to have_dimensions(256 * 2, 256 * 2)
    end
  end

  context 'the large version' do
    it 'scales down a landscape image to fit within 512 by 512 pixels (x2 for retina display)' do
      expect(uploader.large).to have_dimensions(512 * 2, 512 * 2)
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
    filename = 'image.jpg'
    expect(uploader.filename).to eq(filename)
  end
end
