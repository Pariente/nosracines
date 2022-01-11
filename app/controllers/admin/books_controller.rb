class Admin::BooksController < ApplicationController
  before_action :authenticate_admin!
  def search
    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # Books
      title   = Book.arel_table[:title]
      author  = Book.arel_table[:author]
      summary = Book.arel_table[:summary]
      notes   = Book.arel_table[:notes]
      isbn    = Book.arel_table[:isbn]
      @books  = Book.where(title.matches("%#{@keywords}%")).or(
                Book.where(author.matches("%#{@keywords}%"))).or(
                Book.where(summary.matches("%#{@keywords}%"))).or(
                Book.where(notes.matches("%#{@keywords}%"))).or(
                Book.where(isbn.matches("%#{@keywords}%"))
      )
    end
    @books = @books.order(created_at: :desc).page params[:page]
    render "admin/books/index"
  end

  def show
    @book           = Book.find(params[:id])
    @book_documents = @book.book_documents
    @book_events    = @book.book_events
    @book_locations = @book.book_locations
    @book_people    = @book.book_people
  end

  def index
    @books = Book.all
    @books = @books.order(created_at: :desc).page params[:page]
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.create(book_params)
    redirect_to admin_books_path
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    redirect_to admin_book_path(@book)
  end

  def delete
    @book = Book.find(params[:book_id])
    @book.destroy
    redirect_to admin_books_path
  end

  def book_params
    params.require(:book).permit(
      :title,
      :cover,
      :author,
      :publisher,
      :date_publication,
      :isbn,
      :summary,
      :notes,
      :privacy)
  end
end
