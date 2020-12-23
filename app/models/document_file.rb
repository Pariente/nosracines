class DocumentFile < ApplicationRecord
  belongs_to :document
  has_one_attached :url

  def icon
    case original_format
    when "png"
      return "image"
    when "jpg"
      return "image"
    when "jpeg"
      return "image"
    when "tif"
      return "image"
    when "pdf"
      return "text_snippet"
    end
  end
end
