class Person < ApplicationRecord
  has_many :document_people
  has_many :aliases
  has_one_attached :profile_pic

  mount_uploader :profile_pic, ProfilePicUploader

  def name
    full_name = ""
    full_name = self.first_name + " " + self.middle_name + " " + self.last_name
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

  def profile_picture
    doc = self.documents.first
    file = doc.document_files.first
    
    return file
  end
end
