# frozen_string_literal: true

require 'bundler'

env = ENV['APP_ENV']&.to_sym || ENV['RACK_ENV']&.to_sym || :development

Bundler.require(:default, env)

require_relative './classifier'

run Classifier
