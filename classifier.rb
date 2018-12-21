# frozen_string_literal: true

require_relative 'lib/py'
require_relative 'lib/named_entity_recognition'

class Classifier < Sinatra::Base
  include ::SemanticLogger::Loggable

  set :app_file, __FILE__
  set :server, :puma

  ::SemanticLogger.default_level = :info
  formatter = nil

  if development?
    ::SemanticLogger.default_level = :trace
    formatter = :color
  end

  ::SemanticLogger.add_appender(io: $stdout, formatter: formatter)

  get '/' do
    'classifier'
  end

  get '/health' do
    'ok'
  end

  post '/ner' do
    content_type :json
    NamedEntityRecognition.recognize(params[:text]).to_json
  end
end
