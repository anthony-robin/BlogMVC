CarrierWave.configure do |config|
  config.enable_processing = false
end

CarrierWave::Uploader::Base.descendants.each do |klass|
  next if klass.anonymous?
  klass.class_eval do
    def cache_dir
      Rails.root.join('spec', 'support', 'uploads', 'tmp')
    end

    def store_dir
      Rails.root.join('spec', 'support', 'uploads', model.class.to_s.underscore.to_s, mounted_as.to_s, model.id.to_s)
    end
  end
end

RSpec.configure do |config|
  config.after(:each) do
    if Rails.env.test?
      uploads = Rails.root.join('spec', 'support', 'uploads')
      FileUtils.rm_rf(Dir[uploads])
    end
  end
end
