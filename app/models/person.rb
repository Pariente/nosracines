class Person < ApplicationRecord

  has_many :a_links, class_name: "FamilyLink", foreign_key: "person_a_id", dependent: :delete_all
  has_many :b_links, class_name: "FamilyLink", foreign_key: "person_b_id", dependent: :delete_all

  has_many :document_people, dependent: :destroy
  has_many :event_people, dependent: :destroy
  has_many :location_people, dependent: :destroy

  has_many :aliases, dependent: :destroy

  has_one_attached :profile_pic

  paginates_per 25

  def name
    full_name = ""
    full_name = self.first_name + " " + self.middle_name + " " + self.last_name
    return full_name
  end

  def full_name_index
    full_name = ""
    full_name = self.last_name.upcase + " " + self.first_name + " " + self.middle_name
    return full_name
  end

  def documents
    document_people = self.document_people
    docs = []
    document_people.each do |q|
      docs << q.document
    end

    return docs
  end

  def events
    event_people = self.event_people
    events = []
    event_people.each do |ep|
      events << ep.event
    end

    return events
  end

  def locations
    location_people = self.location_people
    locations = []
    location_people.each do |q|
      locations << q.location
    end

    return locations
  end

  def family_links
    a_links = self.a_links
    b_links = self.b_links
    links = a_links + b_links
    return links
  end
end
