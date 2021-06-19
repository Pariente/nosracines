class Admin::DocumentFilesController < ApplicationController
  def new
    @document_file = DocumentFile.new()
    @document = Document.find(params[:document_id])
  end

  def create
    @document = Document.find(params[:document_id])
    @document.document_files.create(document_file_params)
    redirect_to admin_document_path(@document)
  end

  def edit
    @document_file = DocumentFile.find(params[:id])
    @document = @document_file.document
  end

  def update
    @document_file = DocumentFile.find(params[:id])
    @document_file.update(document_file_params)
    redirect_to admin_document_path(@document_file.document)
  end

  def delete
    @document_file = DocumentFile.find(params[:document_file_id])
    document = @document_file.document
    @document_file.destroy
    redirect_to admin_document_path(document)
  end

  def document_file_params
    params.require(:document_file).permit(
      :url,
      :name,
      :transcript,
      :translation_fr,
      :language,
      :comment,
      :persons_position,
      :original_format,
      :color,
      :document_id)
  end
end