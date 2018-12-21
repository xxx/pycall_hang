# frozen_string_literal: true

require_relative './spec_helper'

describe 'Classifier' do
  describe 'Endpoints' do
    describe '/ner' do
      it 'returns a json hash of the results of running named entity recognition on the input' do
        text = 'some text'
        post('/ner', text: text)

        expect(last_response).to be_ok
        expect(last_response.content_type).to eq 'application/json'

        parsed = JSON.parse(last_response.body)

        expect(parsed).to match(hash_including(
                                  'people' => Array,
                                  'organizations' => Array,
                                  'locations' => Array
                                ))
      end
    end

    describe '/health' do
      it 'works' do
        get '/health'
        expect(last_response).to be_ok
      end
    end

    describe '/' do
      it 'prints the name of this application' do
        get '/'
        expect(last_response).to be_ok
        expect(last_response.body).to match 'classifier'
      end
    end
  end
end
