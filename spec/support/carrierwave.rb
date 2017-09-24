CarrierWave.configure do |config|
  config.enable_processing = false
end

CarrierWave::Uploader::Base.descendants.each do |klass|
  next if klass.anonymous?

  klass.class_eval do
    def cache_dir
      Rails.root.join('spec', 'support', 'uploads', 'tmp')
    end
  end
end

RSpec.configure do |config|
  config.after do
    uploads = Rails.root.join('spec', 'support', 'uploads')
    FileUtils.rm_rf(Dir[uploads])
  end
end
