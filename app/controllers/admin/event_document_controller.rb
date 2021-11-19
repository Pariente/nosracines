class Admin::EventDocumentsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @event_document = EventDocument.new()
    @document       = Document.find(params[:document_id])
  end

  def create
    @document = Document.find(params[:document_id])
    ed        = params.as_json["event_document"]
    ed.each do |e|
      @document.event_documents.create(
        document_id:    e[1]["document_id"],
        event_id:  @event_id)
    end
    redirect_to admin_document_path(@document)
  end

  def delete
    @event_document = EventDocument.find(params[:event_document_id])
    document = @event_document.document
    @event_document.destroy
    redirect_to admin_document_path(document)
  end

  def event_document_params
    params.require(:event_document).permit(
      :document_id,
      :event_id)
  end
end