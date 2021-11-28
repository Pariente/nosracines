class Document < ApplicationRecord
  has_many :document_files
  has_many :document_people
  has_many :event_documents
  has_many :document_sources
  has_many :location_documents
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

  def events
    event_documents = self.event_documents
    events = []
    event_documents.each do |ed|
      events << ed.event
    end

    return events
  end

  def locations
    location_documents = self.location_documents
    locations = []
    location_documents.each do |q|
      locations << q.location
    end

    return locations
  end

  def self.fund
    fund = Fund.find(self.fund_id)
    return fund
  end
end
