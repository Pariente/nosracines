class DocumentPerson < ActiveRecord::Base
  belong_to :document
  belong_to :person
end
