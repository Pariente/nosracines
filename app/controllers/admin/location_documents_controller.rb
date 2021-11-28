class Admin::LocationDocumentsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @location_document = LocationDocument.new()

    case params[:from]
    when "location"
      @location = Location.find(params[:location_id])
    when "document"
      @document = Document.find(params[:document_id])
    end
  end

  def create
    ld = params.as_json["location_document"]

    case ld["from"]
    when "location"
      @location = Location.find(params[:location_id])
      ld.each do |q|
        @location.location_documents.create(
          location_id: @location.id,
          document_id: q[1]["document_id"])
      end
      redirect_to admin_location_path(@location)
    when "document"
      @document = Document.find(params[:document_id])
      ld.each do |q|
        @document.location_documents.create(
          location_id: q[1]["location_id"],
          document_id: @document.id)
      end
      redirect_to admin_document_path(@document)
    end
  end

  def delete
    @location_document  = LocationDocument.find(params[:location_document_id])
    location            = @location_document.location
    document            = @location_document.document

    @location_document.destroy

    case params[:redirection]
    when "location"
      redirect_to admin_location_path(location)
    when "document"
      redirect_to admin_document_path(document)
    end
  end

  def location_document_params
    params.require(:location_document).permit(
      :location_id,
      :document_id)
  end
end