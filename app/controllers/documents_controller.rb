class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])

    # Filter if doc is private and user should not have access
    private_access = user_signed_in? && current_user.has_private_access
    if @document.privacy && !private_access
      redirect_to private_content_path
    end

    @people     = @document.people
    @events     = @document.events
    @locations  = @document.locations

    # Filter access-restricted contents if the user should not have access to them
    unless private_access
      @people     = @people.select {|p| !p.privacy?}
      @events     = @events.select {|e| !e.privacy?}
      @locations  = @locations.select {|l| !l.privacy?}
    end

    @document_files = @document.document_files
    unless params[:document_file].nil?
      @document_file = DocumentFile.find(params[:document_file])
    end
  end

  def index
  end
end