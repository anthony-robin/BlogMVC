TRANSACTIONAL_FIXTURES_ERROR_MESSAGE = <<-MSG
  Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
  (or set it to false) to prevent uncommitted transactions being used in
  JavaScript-dependent specs.
  During testing, the app-under-test that the browser driver connects to
  uses a different database connection to the database connection used by
  the spec. The app's database connection would not be able to access
  uncommitted transaction data setup over the spec's database connection.
MSG
.freeze

RSpec.configure do |config|
  config.before(:suite) do
    raise(TRANSACTIONAL_FIXTURES_ERROR_MESSAGE) if config.use_transactional_fixtures?
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.append_after(:each) do
    DatabaseCleaner.clean
  end
end