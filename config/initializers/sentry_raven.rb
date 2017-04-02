if Rails.env.staging? || Rails.env.production?
  Raven.configure do |config|
    config.dsn = ENV.fetch('SENTRY_URL')
    config.environments = %w[staging production]
  end
end
