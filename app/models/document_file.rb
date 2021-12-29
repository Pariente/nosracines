class DocumentFile < ApplicationRecord
  belongs_to :document
  # has_one_attached :url
  mount_uploader :url, UrlUploader

  def type
    image_formats = ["gif", "png", "jpg", "jpeg", "heic", "svg", "tif", "tiff"]
    video_formats = ["avi", "mov", "mp4", "wav", "wma", "wmv"]
    audio_formats = ["mid", "mp3"]
    text_formats  = ["doc", "docx", "pdf", "txt"]

    if image_formats.include?(self.original_format)
      return "image"
    elsif video_formats.include?(self.original_format)
      return "video"
    elsif audio_formats.include?(self.original_format)
      return "audio"
    elsif text_formats.include?(self.original_format)
      return "text"
    else
      return "other"
    end
  end
end
