class Book < ApplicationRecord
  has_many :book_documents, dependent: :destroy
  has_many :book_events,    dependent: :destroy
  has_many :book_locations, dependent: :destroy
  has_many :book_people,    dependent: :destroy

  mount_uploader :cover, BookCoverUploader

  paginates_per 25

  def title_and_author
    result = self.title + " (" + self.author + ")"
    return result
  end

  def documents
    book_documents = self.book_documents
    documents = []
    book_documents.each do |q|
      documents << q.document
    end

    return documents
  end

  def events
    book_events = self.book_events
    events = []
    book_events.each do |q|
      events << q.event
    end

    return events
  end

  def locations
    book_locations = self.book_locations
    locations = []
    book_locations.each do |q|
      locations << q.location
    end

    return locations
  end

  def people
    book_people = self.book_people
    people = []
    book_people.each do |q|
      people << q.person
    end

    return people
  end
end
