class DocumentPerson < ApplicationRecord
  belongs_to :document
  belongs_to :person
end
