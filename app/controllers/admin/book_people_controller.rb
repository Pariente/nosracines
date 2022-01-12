class Admin::BookPeopleController < ApplicationController
  before_action :authenticate_admin!
  def new
    @book_person = BookPerson.new()

    case params[:from]
    when "person"
      @person = Person.find(params[:person_id])
    when "book"
      @book = Book.find(params[:book_id])
    end
  end

  def create
    bp = params.as_json["book_person"]

    case bp["from"]
    when "person"
      @person = Person.find(params[:person_id])
      bp.each do |q|
        unless BookPerson.exists?(
            person_id:  @person.id, 
            book_id:    q[1]["book_id"])
          @person.book_people.create(
            person_id:  @person.id,
            book_id:    q[1]["book_id"])
        end
      end
      redirect_to admin_person_path(@person)
    when "book"
      @book = Book.find(params[:book_id])
      bp.each do |q|
        unless BookPerson.exists?(
            person_id:  q[1]["person_id"], 
            book_id:    @book.id)
          @book.book_people.create(
            person_id:  q[1]["person_id"],
            book_id:      @book.id)
        end
      end
      redirect_to admin_book_path(@book)
    end
  end

  def delete
    @book_person  = BookPerson.find(params[:book_person_id])
    person        = @book_person.person
    book          = @book_person.book

    @book_person.destroy

    case params[:redirection]
    when "person"
      redirect_to admin_person_path(person)
    when "book"
      redirect_to admin_book_path(book)
    end
  end

  def book_person_params
    params.require(:book_person).permit(
      :book_id,
      :person_id)
  end
end