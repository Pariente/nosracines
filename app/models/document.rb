class Document < ApplicationRecord
  has_many :document_files
  has_many :document_people
  has_many :event_documents
  has_many :document_sources
  belongs_to :fund

  def format
    return self.document_files.first.original_format
  end

  def people
    document_people = self.document_people
    people = []
    document_people.each do |d|
      people << d.person
    end

    return people
  end

  def self.fund
    fund = Fund.find(self.fund_id)
    return fund
  end
end
