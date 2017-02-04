require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlogMVC
  class Application < Rails::Application
    # I18n
    config.i18n.locale = :fr
    config.default_locale = :fr
    config.i18n.default_locale = :fr

    # Remove Helper, CSS, Coffee generating when scaffolding ressources
    config.generators.helper = false
    config.generators.stylesheets = false
    config.generators.javascripts = false
  end
end
