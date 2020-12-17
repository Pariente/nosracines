class Document < ActiveRecord::Base
  has_many :files
  has_many :documents_people
  has_many :documents_sources
  belongs_to :fund
end
