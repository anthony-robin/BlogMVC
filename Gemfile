source 'https://rubygems.org'

# Core
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma', '~> 3.0'

gem 'sqlite3' # Database
gem 'devise' # Authentication
gem 'cancancan' # Abilities

# Assets
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'slim-rails' # slim file
gem 'foundation-rails', '~> 6.3.0'
gem 'wysiwyg-rails', github: 'froala/wysiwyg-rails' # Froala editor
gem 'kaminari', '~> 1.0' # Pagination
gem 'gretel' # Breadcrumb
gem 'friendly_id'

# Uploaders
gem 'mini_magick'
gem 'carrierwave', '~> 1.0'
gem 'retina_rails',
    github: 'gemsfix/retina_rails',
    branch: 'feature/rails5'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'rails-i18n', '~> 5.0.0' # I18n
gem 'meta-tags' # SEO

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'faker'
  gem 'byebug', platform: :mri
  gem 'database_cleaner'

  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'bullet'
  gem 'annotate', github: 'ctran/annotate_models',
                  branch: 'develop'

  gem 'web-console'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'rails-controller-testing'

  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', '~> 1.0.0', require: false
  gem 'codacy-coverage', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
