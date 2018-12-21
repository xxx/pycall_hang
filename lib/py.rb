# frozen_string_literal: true

# Import all Python modules within here, to prevent any chance of naming
# conflicts with Ruby classes.
module Py
  extend PyCall::Import
  pyimport 'spacy'
end
