class Event < ApplicationRecord

  has_many :event_people
  has_many :event_documents

  has_one_attached :illustration

  paginates_per 25

  def documents
    event_documents = self.event_documents
    docs = []
    event_documents.each do |q|
      docs << q.document
    end

    return docs
  end

  def people
    event_people = self.event_people
    people = []
    event_people.each do |q|
      people << q.person
    end

    return people
  end
end
