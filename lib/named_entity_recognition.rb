# frozen_string_literal: true

class NamedEntityRecognition
  include ::SemanticLogger::Loggable

  NLP = Py::spacy.load('en') # rubocop:disable Style/ColonMethodCall

  # https://spacy.io/api/annotation#named-entities
  PERSON = 'PERSON'
  LOCATION = 'LOC'
  GEO_POLITICAL_ENTITY = 'GPE'
  ORGANIZATION = 'ORG'

  def self.recognize(input)
    entities = NLP.__call__(input).ents.to_a

    {
      people: filter_for(entities, PERSON),
      locations: filter_for(entities, LOCATION, GEO_POLITICAL_ENTITY),
      organizations: filter_for(entities, ORGANIZATION)
    }
  end

  def self.filter_for(entities, *types)
    entities
      .select { |e| types.include?(e.label_) && !e.text.match?(/\A\p{Space}+\z/) }
      .map(&:text)
      .uniq
  end

  private_class_method :filter_for
end
