# frozen_string_literal: true

source 'https://rubygems.org'

gem 'fast-stemmer'
gem 'htmlentities'
gem 'json'
gem 'loofah'
gem 'puma'
gem 'pycall', require: 'pycall/import'
gem 'rack'
gem 'rake'
gem 'semantic_logger'
gem 'sinatra', require: 'sinatra/base'

group :development, :test do
  gem 'debase', '0.2.3.beta2'
  gem 'pry'
  gem 'pry-byebug'
  gem 'ruby-debug-ide', '0.7.0.beta6'
end

group :development do
  gem 'rubocop', require: false
  gem 'sinatra-contrib', require: false
end

group :test do
  gem 'rack-test', require: false
  gem 'rspec'
end
