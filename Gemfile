source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Core
gem 'rails', '~> 5.1.3'
gem 'puma', '~> 3.8'

gem 'sqlite3', group: %i[development test] # Database
gem 'pg', group: %i[staging production] # Database
gem 'devise' # Authentication
gem 'cancancan' # Abilities

# Assets
gem 'sassc-rails'

# Forms
gem 'reform-rails'
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'slim-rails' # slim file
gem 'kaminari', '~> 1.0' # Pagination
gem 'breadcrumbs_on_rails'
gem 'friendly_id'

gem 'acts-as-taggable-on', '~> 5.0' # Taggable
gem 'acts_as_commentable_with_threading' # Commentable

# Searchable
gem 'searchkick'

# Uploaders
gem 'mini_magick'
gem 'carrierwave', '~> 1.0'

gem 'active_model_serializers', '~> 0.10.0'
gem 'webpacker'

gem 'rails-i18n', '~> 5.0.0' # I18n
gem 'meta-tags' # SEO
gem 'dotenv-rails'

# Mailers
gem 'inky-rb', require: 'inky'
gem 'premailer-rails'

gem 'shog' # Colored logs
gem 'ribbonit'

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :staging, :production do
  gem 'bugsnag'
  gem 'lograge' # Condensed logs
end

group :development, :test do
  gem 'faker'
  gem 'database_cleaner'
  gem 'rubocop'

  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-theme'
  gem 'pry-alias'

  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'bullet'
  gem 'color_route'
  gem 'meta_request'
  gem 'annotate'

  gem 'web-console'
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '~> 2.14'
  gem 'capybara-screenshot', require: false
  gem 'selenium-webdriver', require: false

  gem 'shoulda-matchers', '~> 3.1'
  gem 'rails-controller-testing'

  gem 'simplecov', require: false
  gem 'codeclimate-test-reporter', '~> 1.0.0', require: false
  gem 'codacy-coverage', require: false
end
