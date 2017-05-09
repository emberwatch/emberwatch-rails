source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Core
gem 'rails', '~> 5.0.1'

# Database
gem 'pg', '~> 0.18'

# Server
gem 'puma', '~> 3.0'

# Serialization
gem 'active_model_serializers', '~> 0.10.0'

# CORS
gem 'rack-cors', '~> 0.4.1', require: 'rack/cors'

###############################################
# Development dependencies
###############################################

group :development, :test do
  # Pry console
  gem 'pry',                    '~> 0.10.4'
  gem 'pry-rails',              '~> 0.3.6'

  # RSpec testing instead of Test::Unit
  gem 'rspec-rails',            '~> 3.6'

  # Test factories and dummy data
  gem 'factory_girl_rails',     '~> 4.8'

  # Guard
  gem 'guard',                  '~> 2.14',  require: false
  gem 'guard-rspec',            '~> 4.7',   require: false
end

###############################################
# Test dependencies
###############################################

group :test do
  # Active Model Serializer testing
  gem 'shoulda-matchers', github: 'thoughtbot/shoulda-matchers', branch: 'rails-5'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
