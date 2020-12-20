class DocumentSource < ApplicationRecord
  belongs_to :document
  belongs_to :source
end
