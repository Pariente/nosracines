class DocumentSource < ActiveRecord::Base
  belongs_to :document
  belongs_to :source
end
