class Admin::DocumentsController < ApplicationController
  before_action :authenticate_admin!
  def search
    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # Documents
      name = Document.arel_table[:name]
      @documents = Document.where(name.matches("%#{@keywords}%"))
    end
    @documents = @documents.order(created_at: :desc).page params[:page]
    render "admin/documents/index"
  end

  def index
    @documents = Document.all
    @documents = @documents.order(created_at: :desc).page params[:page]
  end

  def show
    @document = Document.find(params[:id])
    @document_people = @document.document_people
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.create(document_params)
    redirect_to new_admin_document_document_file_path(document_id: @document.id)
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    @document.update(document_params)
    redirect_to admin_document_path(@document)
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