class File < ActiveRecord::Base
  belongs_to :document

  mount_uploader :url, UrlUploader
end
