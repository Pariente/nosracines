class Document < ApplicationRecord
  has_many :document_files
  has_many :document_people
  has_many :document_sources
  belongs_to :fund
end
