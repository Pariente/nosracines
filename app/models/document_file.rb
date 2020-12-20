class DocumentFile < ApplicationRecord
  belongs_to :document
  has_one_attached :url

  # mount_uploader :url, UrlUploader
end
