class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
    @document_files = @document.document_files
    unless params[:document_file].nil?
      @document_file = DocumentFile.find(params[:document_file])
    end
  end

  def index
  end
end