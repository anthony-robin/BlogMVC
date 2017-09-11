ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'cancan/matchers'
require 'carrierwave/test/matchers'

# This is needed by CI to be aware of page objects.
require Rails.root.join('spec', 'support', 'application_page.rb')

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
Dir[Rails.root.join('spec', 'features', 'shared_examples', '**', '*.rb')].each do |f|
  require f
end

ActiveRecord::Migration.check_pending!
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include AbstractController::Translation

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
