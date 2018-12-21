# frozen_string_literal: true

require 'bundler'
Bundler.require(:default, :test)

require 'rack/test'

ENV['APP_ENV'] = ENV['RACK_ENV'] = 'test'

require_relative '../classifier'

module RSpecMixin
  include Rack::Test::Methods
  def app
    Classifier
  end
end

RSpec.configure { |c| c.include RSpecMixin }
