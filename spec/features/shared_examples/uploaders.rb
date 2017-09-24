RSpec.shared_examples_for :uploader_configuration do
  describe '#extension_whitelist' do
    subject { uploader.extension_whitelist }

    it { is_expected.to eq extension_whitelist }
  end

  describe '#filename' do
    subject { uploader.filename }

    it { is_expected.to eq filename }
  end

  describe '#store_dir' do
    subject { uploader.store_dir }

    it { is_expected.to eq store_dir }
  end

  describe 'file' do
    subject { uploader }

    it { is_expected.to be_format format }
    it { is_expected.to have_permissions(permissions) }
  end
end
