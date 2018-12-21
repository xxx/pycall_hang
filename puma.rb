# frozen_string_literal: true

port        ENV['PORT'] || 5000
environment ENV['APP_ENV'] || ENV['RACK_ENV'] || 'development'

preload_app!
