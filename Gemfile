source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'active_model_serializers', '~> 0.10.0'
gem 'acts-as-taggable-on', '~> 5.0'
gem 'acts_as_commentable_with_threading'
gem 'breadcrumbs_on_rails'
gem 'cancancan'
gem 'carrierwave', '~> 1.0'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'
gem 'dotenv-rails'
gem 'friendly_id'
gem 'goldiloader'
gem 'inky-rb', require: 'inky'
gem 'kaminari', '~> 1.0'
gem 'meta-tags'
gem 'mini_magick'
gem 'pg', group: %i[staging production]
gem 'premailer-rails'
gem 'puma', '~> 3.8'
gem 'rails-i18n', '~> 5.0.0'
gem 'reform-rails', '~> 0.2.0.rc1'
gem 'ribbonit'
gem 'sassc-rails'
gem 'searchkick'
gem 'shog'
gem 'simple_form'
gem 'slim-rails'
gem 'sorcery'
gem 'sqlite3', group: %i[development test]
gem 'webpacker'

group :staging, :production do
  gem 'bugsnag'
  gem 'lograge'
end

group :development, :test do
  gem 'bullet'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-alias'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-theme'
  gem 'rspec-rails', '~> 3.5'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'slim_lint', require: false
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'color_route'
  gem 'listen'
  gem 'meta_request'
  gem 'rails-erd'
  gem 'rails_db'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console'
end

group :test do
  gem 'capybara', '~> 2.14'
  gem 'capybara-screenshot', require: false
  gem 'codacy-coverage', require: false
  gem 'rails-controller-testing'
  gem 'selenium-webdriver', require: false
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end
