class Admin::EventDocumentsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @event_document = EventDocument.new()

    case params[:from]
    when "document"
      @document = Document.find(params[:document_id])
    when "event"
      @event = Event.find(params[:event_id])
    end
  end

  def create
    ed = params.as_json["event_document"]
    case ed["from"]
    when "document"
      @document = Document.find(params[:document_id])
      ed.each do |q|
        unless EventDocument.exists?(
            document_id:  @document.id,
            event_id:     q[1]["event_id"])
          @document.event_documents.create(
            document_id:  @document.id,
            event_id:     q[1]["event_id"])
        end
      end
      redirect_to admin_document_path(@document)
    when "event"
      @event  = Event.find(params[:event_id])
      ed.each do |q|
        unless EventDocument.exists?(
            document_id:  q[1]["document_id"],
            event_id:     @event.id)
          @event.event_documents.create(
            document_id:  q[1]["document_id"],
            event_id:     @event.id)
        end
      end
      redirect_to admin_event_path(@event)
    end
  end

  def delete
    @event_document = EventDocument.find(params[:event_document_id])
    document        = @event_document.document
    event           = @event_document.event
    
    @event_document.destroy

    case params[:redirection]
    when "event"
      redirect_to admin_event_path(event)
    when "document"
      redirect_to admin_document_path(document)
    end
  end

  def event_document_params
    params.require(:event_document).permit(
      :document_id,
      :event_id)
  end
end