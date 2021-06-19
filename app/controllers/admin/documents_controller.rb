class Admin::DocumentsController < ApplicationController
  def index
    @documents = Document.all
    @documents = @documents.order(created_at: :desc).page params[:page]
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(document_params)
    redirect_to new_admin_document_document_file_path(document_id: @document.id)
  end

  def document_params
    params.require(:document).permit(
      :name,
      :date,
      :location,
      :reference,
      :box,
      :fund_id,
      :notes)
  end
end