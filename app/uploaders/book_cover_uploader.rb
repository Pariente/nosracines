class BookCoverUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave
end