class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])
    @documents = @person.documents

    # Images
    image_formats = ["png", "jpg", "jpeg", "tiff"]
    @images = @documents.select {|d| image_formats.include?(d.format) }

    # Texts
    text_formats = ["pdf", "txt", "doc", "docx"]
    @texts = @documents.select {|d| text_formats.include?(d.format) }
  end
end