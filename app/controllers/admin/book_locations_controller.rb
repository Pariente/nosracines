class Admin::BookLocationsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @book_location = BookLocation.new()

    case params[:from]
    when "location"
      @location = Location.find(params[:location_id])
    when "book"
      @book = Book.find(params[:book_id])
    end
  end

  def create
    be = params.as_json["book_location"]

    case be["from"]
    when "location"
      @location = Location.find(params[:location_id])
      be.each do |q|
        unless BookLocation.exists?(
            location_id:  @location.id, 
            book_id:      q[1]["book_id"])
          @location.book_locations.create(
            location_id:  @location.id,
            book_id:      q[1]["book_id"])
        end
      end
      redirect_to admin_location_path(@location)
    when "book"
      @book = Book.find(params[:book_id])
      be.each do |q|
        unless BookLocation.exists?(
            location_id:  q[1]["location_id"], 
            book_id:      @book.id)
          @book.book_locations.create(
            location_id:  q[1]["location_id"],
            book_id:      @book.id)
        end
      end
      redirect_to admin_book_path(@book)
    end
  end

  def delete
    @book_location  = BookLocation.find(params[:book_location_id])
    location        = @book_location.location
    book            = @book_location.book

    @book_location.destroy

    case params[:redirection]
    when "location"
      redirect_to admin_location_path(location)
    when "book"
      redirect_to admin_book_path(book)
    end
  end

  def book_location_params
    params.require(:book_location).permit(
      :book_id,
      :location_id)
  end
end