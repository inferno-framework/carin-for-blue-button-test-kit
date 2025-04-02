# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gem 'inferno_core',
    git: 'https://github.com/inferno-framework/inferno-core.git',
    branch: 'fi-3813-ms-fixes'

group :development, :test do
  gem 'debug'
  gem 'foreman'
  gem 'roo', '~> 2.7.1'
end

group :test do
  gem 'database_cleaner-sequel', '~> 1.8'
  gem 'factory_bot', '~> 6.1'
  gem 'rack-test'
  gem 'rspec', '~> 3.10'
  gem 'webmock', '~> 3.11'
end
