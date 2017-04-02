ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'cancan/matchers'
require 'carrierwave/test/matchers'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }
Dir[Rails.root.join('spec', 'features', 'shared_examples', '**', '*.rb')].each do |f|
  require f
end

RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller
  config.include FactoryGirl::Syntax::Methods
  config.include AbstractController::Translation
  config.include Devise::Test::ControllerHelpers, type: :controller

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  ActiveRecord::Migration.check_pending!
  ActiveRecord::Migration.maintain_test_schema!
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.library :rails
    with.test_framework :rspec
  end
end
