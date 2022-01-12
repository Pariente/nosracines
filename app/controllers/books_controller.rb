class BooksController < ApplicationController
  def show
    @search_bar = true
    @book = Book.find(params[:id])

    # Filter if person is private and user should not have access
    private_access = user_signed_in? && current_user.has_private_access
    if @book.privacy && !private_access
      redirect_to private_content_path
    end

    @documents  = @book.documents
    @events     = @book.events
    @locations  = @book.locations
    @people     = @book.people
  end

  def index
    private_access  = user_signed_in? && current_user.has_private_access
    @books          = Book.all.sort_by {|b| b.title}

    # Filter access-restricted contents if the user should not have access to them
    unless private_access
      @books = @books.select {|b| !b.privacy?}
    end

    @books = Kaminari.paginate_array(@books).page(params[:page]).per(24)
  end

  def search
    private_access  = user_signed_in? && current_user.has_private_access
    @books          = helpers.search_books({
                        keywords: params[:keywords], 
                        private_access: private_access
                      })[:books]
    @books          = Kaminari.paginate_array(@books).page(params[:page]).per(24)
  end

  def book_params
    params.require(:book).permit(
      :title,
      :cover,
      :author,
      :publisher,
      :isbn,
      :date_publication,
      :summary,
      :notes)
  end
end