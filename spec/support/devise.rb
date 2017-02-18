RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
end
