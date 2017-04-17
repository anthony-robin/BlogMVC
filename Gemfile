source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Core
gem 'rails', '~> 5.1.0.rc1'
gem 'puma', '~> 3.8'

gem 'sqlite3' # Database
gem 'devise' # Authentication
gem 'cancancan' # Abilities

# Assets
gem 'jquery-rails'
gem 'sassc-rails'
gem 'font-awesome-sass',
    github: 'xijo/font-awesome-sass',
    branch: 'use_sassc_rails_if_available' # Fix to use sassc
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'slim-rails' # slim file
gem 'foundation-rails', '~> 6.3.0'
gem 'wysiwyg-rails' # Froala editor
gem 'kaminari', '~> 1.0' # Pagination
gem 'gretel' # Breadcrumb
gem 'friendly_id'
gem 'acts-as-taggable-on', '~> 4.0'

# Commentable
gem 'acts_as_commentable_with_threading'

# Searchable
gem 'searchkick'

# Uploaders
gem 'mini_magick'
gem 'carrierwave', '~> 1.0'
gem 'retina_rails',
    github: 'gemsfix/retina_rails',
    branch: 'feature/rails5'

gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'webpacker', github: 'rails/webpacker'

gem 'rails-i18n', '~> 5.0.0' # I18n
gem 'meta-tags' # SEO
gem 'dotenv-rails'

gem 'shog' # Colored logs

# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :staging, :production do
  gem 'lograge' # Condensed logs
  gem 'sentry-raven'
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
  gem 'annotate', github: 'ctran/annotate_models',
                  branch: 'develop'

  gem 'web-console'
  gem 'better_errors', github: 'charliesome/better_errors'
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
