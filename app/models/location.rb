class Location < ApplicationRecord
  has_many :location_people,    dependent: :destroy
  has_many :location_documents, dependent: :destroy
  has_many :location_events,    dependent: :destroy
  has_many :book_locations,     dependent: :destroy

  has_one_attached :illustration

  paginates_per 25

  def documents
    location_documents = self.location_documents
    docs = []
    location_documents.each do |q|
      docs << q.document
    end

    return docs
  end

  def people
    location_people = self.location_people
    people = []
    location_people.each do |q|
      people << q.person
    end

    return people
  end

  def events
    location_events = self.location_events
    events = []
    location_events.each do |q|
      events << q.event
    end

    return events
  end

  def books
    book_locations  = self.book_locations
    books           = []
    book_locations.each do |q|
      books << q.book
    end

    return books
  end
end
