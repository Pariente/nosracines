class Person < ApplicationRecord
  has_many :document_people
  has_many :aliases
  has_one_attached :profile_pic

  mount_uploader :profile_pic, ProfilePicUploader
end
