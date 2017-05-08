require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'capybara-screenshot/rspec'

# Capybara
Capybara.asset_host = 'http://localhost:3000'
Capybara.save_path = Rails.root.join('tmp', 'capybara')
Capybara.default_driver = :rack_test

# Poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    js_errors: false,
    inspector: false,
    phantomjs_options: ['--load-images=no', '--ignore-ssl-errors=yes'],
    timeout: 120
  )
end

# Capybara Screenshot
Capybara::Screenshot.prune_strategy = :keep_last_run
