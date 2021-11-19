class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])

    # Filter if doc is private and user should not have access
    private_access = user_signed_in? && current_user.has_private_access
    if @document.privacy && !private_access
      redirect_to private_content_path
    end

    @document_files = @document.document_files
    unless params[:document_file].nil?
      @document_file = DocumentFile.find(params[:document_file])
    end
  end

  def index
  end
end