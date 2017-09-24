require 'rails_helper'

RSpec.describe ImageUploader do
  include CarrierWave::Test::Matchers

  let(:picture) { create(:picture, :for_blog) }
  let(:uploader) { described_class.new(picture, :image) }

  before do
    described_class.enable_processing = true
    path_to_file = Rails.root.join('spec', 'fixtures', 'picture.png')
    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    described_class.enable_processing = false
    uploader.remove!
  end

  describe 'configuration' do
    let(:format) { 'png' }
    let(:permissions) { 0644 }
    let(:store_dir) { "uploads/picture/#{picture.id}" }
    let(:filename) { 'image.jpg' }
    let(:extension_whitelist) { %w[jpg jpeg png] }

    it_behaves_like :uploader_configuration
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
      expect(uploader.large_2x).to have_dimensions(1_200, 1_200)
    end
  end
end
