TRANSACTIONAL_FIXTURES_ERROR_MESSAGE = <<-MSG.freeze
  Delete line `config.use_transactional_fixtures = true` from rails_helper.rb
  (or set it to false) to prevent uncommitted transactions being used in
  JavaScript-dependent specs.
  During testing, the app-under-test that the browser driver connects to
  uses a different database connection to the database connection used by
  the spec. The app's database connection would not be able to access
  uncommitted transaction data setup over the spec's database connection.
MSG

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = if example.metadata[:js]
      :truncation
    else
      :transaction
    end
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
