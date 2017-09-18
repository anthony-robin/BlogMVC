source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.3'
gem 'puma', '~> 3.8'
gem 'sqlite3', group: %i[development test]
gem 'pg', group: %i[staging production]

gem 'devise'
gem 'cancancan'

gem 'reform-rails'
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'slim-rails'
gem 'kaminari', '~> 1.0'
gem 'breadcrumbs_on_rails'
gem 'friendly_id'

gem 'acts-as-taggable-on', '~> 5.0'
gem 'acts_as_commentable_with_threading'

gem 'searchkick'
gem 'active_model_serializers', '~> 0.10.0'

gem 'mini_magick'
gem 'carrierwave', '~> 1.0'

gem 'sassc-rails'
gem 'webpacker'

gem 'rails-i18n', '~> 5.0.0'
gem 'meta-tags'
gem 'dotenv-rails'

gem 'inky-rb', require: 'inky'
gem 'premailer-rails'

gem 'shog'
gem 'ribbonit'

group :staging, :production do
  gem 'bugsnag'
  gem 'lograge'
end

group :development, :test do
  gem 'faker'
  gem 'database_cleaner'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'slim_lint', require: false

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

  gem 'rails_db'
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
