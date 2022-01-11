class Event < ApplicationRecord
  has_many :event_people,     dependent: :destroy
  has_many :event_documents,  dependent: :destroy
  has_many :location_events,  dependent: :destroy
  has_many :book_events,      dependent: :destroy

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

  def images
    documents     = self.documents
    image_formats = ["gif", "png", "jpg", "jpeg", "tif", "tiff", "heic", "svg"]
    images = []
    images = documents.select {|d| image_formats.include?(d.format) }

    return images
  end

  def audios
    documents     = self.documents
    audio_formats = ["mid", "mp3"]
    audios = []
    audios = documents.select {|d| audio_formats.include?(d.format) }
    
    return audios
  end

  def videos
    documents     = self.documents
    video_formats = ["avi", "mov", "mp4", "wav", "wma", "wmv"]
    videos = []
    videos = documents.select {|d| video_formats.include?(d.format) }
    
    return videos
  end

  def people
    event_people = self.event_people
    people = []
    event_people.each do |q|
      people << q.person
    end

    return people
  end

  def locations
    location_events = self.location_events
    locations = []
    location_events.each do |q|
      locations << q.location
    end

    return locations
  end
end
