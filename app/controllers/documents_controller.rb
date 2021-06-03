class DocumentsController < ApplicationController
  def show
    @document = Document.find(params[:id])
    @document_files = @document.document_files
  end

  def index
  end
end