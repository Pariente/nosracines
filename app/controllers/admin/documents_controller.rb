class Admin::DocumentsController < ApplicationController
  before_action :authenticate_admin!
  def search
    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # Documents
      name        = Document.arel_table[:name]
      @documents  = Document.where(name.matches("%#{@keywords}%"))
    end
    @documents = @documents.order(created_at: :desc).page params[:page]
    render "admin/documents/index"
  end

  def index
    @documents = Document.all
    @documents = @documents.order(created_at: :desc).page params[:page]
  end

  def show
    @document           = Document.find(params[:id])
    @document_people    = @document.document_people
    @event_documents    = @document.event_documents
    @location_documents = @document.location_documents
  end

  def new
    @document       = Document.new
    @document_files = @document.document_files.build
  end

  def multiple_new 
    @document       = Document.find(params[:document_id])
    @document_files = @document.document_files.build
  end

  def multiple_create
    @document = Document.find(params[:document_id])
    params[:document_files]['url'].each do |a|
      @document_file = @document.document_files.create!(:url => a, :document_id => @document.id)
    end
    format.html { redirect_to admin_document_path(@document), notice: 'Fichiers ajoutés avec succès.' }
  end

  def create
    @document = Document.create(document_params)
    params[:document_files]['url'].each do |a|
      @document_file = @document.document_files.create!(:url => a, :document_id => @document.id)
    end
    redirect_to admin_document_path(@document)
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    @document.update(document_params)
    unless params[:document_files].nil?
      params[:document_files]['url'].each do |a|
        @document_file = @document.document_files.create!(:url => a, :document_id => @document.id)
      end
    end
    redirect_to admin_document_path(@document)
  end

  def delete
    @document = Document.find(params[:document_id])
    @document.destroy
    redirect_to admin_documents_path
  end

  def document_params
    params.require(:document).permit(
      :name,
      :date,
      :location,
      :reference,
      :box,
      :fund_id,
      :notes,
      :privacy,
      {document_files_attributes: [:id, :document_id, :url]})
  end
end