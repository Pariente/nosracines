class DocumentFilesController < ApplicationController
  def new
    @document_file = DocumentFile.new
  end

  def create
    @document_file = DocumentFile.new(document_file_params)
    @document_file.save
    redirect_to new_document_file_path
  end

  def show
    @document_file = DocumentFile.find(params[:id])
  end

  def document_file_params
    params.require(:document_file).permit(
      :url,
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