# frozen_string_literal: true

require_relative './spec_helper'

describe NamedEntityRecognition do
  describe '.recognize' do
    let(:text) do
      <<~TEXT
        On August 24, 1673, during the Third Anglo-Dutch War, Dutch captain Anthony Colve seized the colony of
        New York from England at the behest of Cornelis Evertsen the Youngest and rechristened it "New Orange"
        after William III, the Prince of Orange. The Dutch would soon return the island to England under the Treaty
        of Westminster of November 1674.

        Several intertribal wars among the Native Americans and some epidemics brought on by contact with the
        Europeans caused sizeable population losses for the Lenape between the years 1660 and 1670.
        By 1700, the Lenape population had diminished to 200. New York experienced several yellow fever epidemics
        in the 18th century, losing ten percent of its population to the disease in 1702 alone.
      TEXT
    end

    subject { described_class.recognize(text) }

    it 'returns the people, locations, and organizations that are mined from the text' do
      expect(subject).to match hash_including(
        locations: array_including('New York', 'England', 'Lenape'),
        organizations: array_including('Lenape'),
        people: array_including('Anthony Colve', 'Cornelis Evertsen', 'William III', 'the Prince of Orange')
      )
    end

    it 'does not include duplicates' do
      locations = subject.fetch(:locations)
      expect(locations.uniq).to eq locations
    end

    it 'filters out newlines from the lists' do
      %i[people locations organizations].each do |field|
        expect(subject.fetch(field)).to_not include("\n")
      end
    end
  end
end
