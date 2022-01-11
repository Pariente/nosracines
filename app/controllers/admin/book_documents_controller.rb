class Admin::BookDocumentsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @book_document = BookDocument.new()

    case params[:from]
    when "document"
      @document = Document.find(params[:document_id])
    when "book"
      @book = Book.find(params[:book_id])
    end
  end

  def create
    bd = params.as_json["book_document"]

    case bd["from"]
    when "document"
      @document = Document.find(params[:document_id])
      bd.each do |q|
        @document.book_documents.create(
          document_id:  @document.id,
          book_id:      q[1]["book_id"])
      end
      redirect_to admin_document_path(@document)
    when "book"
      @book = Book.find(params[:book_id])
      bd.each do |q|
        @book.book_documents.create(
          document_id:  q[1]["document_id"],
          book_id:      @book.id)
      end
      redirect_to admin_book_path(@book)
    end
  end

  def delete
    @book_document  = BookDocument.find(params[:book_document_id])
    document        = @book_document.document
    book            = @book_document.book

    @book_document.destroy

    case params[:redirection]
    when "document"
      redirect_to admin_document_path(document)
    when "book"
      redirect_to admin_book_path(book)
    end
  end

  def book_document_params
    params.require(:book_document).permit(
      :book_id,
      :document_id)
  end
end