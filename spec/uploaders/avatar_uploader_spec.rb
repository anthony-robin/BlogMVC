require 'rails_helper'

RSpec.describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { described_class.new(user, :avatar) }

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
    let(:store_dir) { "uploads/user/#{user.id}" }
    let(:filename) { 'avatar.jpg' }
    let(:extension_whitelist) { %w[jpg jpeg png] }

    it_behaves_like :uploader_configuration
  end

  describe 'the small version' do
    it 'scales down avatar to fill within 100 by 100 pixels' do
      expect(uploader.small).to have_dimensions(100, 100)
    end

    it 'scales down avatar to fill within 200 by 200 pixels (retina)' do
      expect(uploader.small_2x).to have_dimensions(200, 200)
    end
  end

  describe 'the large version' do
    it 'scales down avatar to fill within 200 by 200 pixels' do
      expect(uploader.large).to have_dimensions(200, 200)
    end

    it 'scales down avatar to fill within 400 by 400 pixels (retina)' do
      expect(uploader.large_2x).to have_dimensions(400, 400)
    end
  end
end
