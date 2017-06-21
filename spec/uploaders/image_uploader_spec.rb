require 'rails_helper'

RSpec.describe ImageUploader do
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
    it 'scales down a picture to fit within 50 by 50 pixels' do
      expect(uploader.thumb).to have_dimensions(50, 50)
    end

    it 'scales down a picture to fit within 100 by 100 pixels (retina)' do
      expect(uploader.thumb_2x).to have_dimensions(100, 100)
    end
  end

  context 'the small version' do
    it 'scales down a picture to fit within 150 by 150 pixels' do
      expect(uploader.small).to have_dimensions(150, 150)
    end

    it 'scales down a picture to fit within 300 by 300 pixels (retina)' do
      expect(uploader.small_2x).to have_dimensions(300, 300)
    end
  end

  context 'the medium version' do
    it 'scales down a picture to fit within 300 by 300 pixels' do
      expect(uploader.medium).to have_dimensions(300, 300)
    end

    it 'scales down a picture to fit within 600 by 600 pixels (retina)' do
      expect(uploader.medium_2x).to have_dimensions(600, 600)
    end
  end

  context 'the large version' do
    it 'scales down a picture to fit within 600 by 600 pixels' do
      expect(uploader.large).to have_dimensions(600, 600)
    end

    it 'scales down a picture to fit within 1200 by 1200 pixels (retina)' do
      expect(uploader.large_2x).to have_dimensions(1200, 1200)
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
