if Rails.env.staging? || Rails.env.production?
  Bugsnag.configure do |config|
    config.api_key = ENV.fetch('BUGSNAG_API_KEY')
  end
end
