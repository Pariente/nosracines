class Admin::BookEventsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @book_event = BookEvent.new()

    case params[:from]
    when "event"
      @event = Event.find(params[:event_id])
    when "book"
      @book = Book.find(params[:book_id])
    end
  end

  def create
    be = params.as_json["book_event"]

    case be["from"]
    when "event"
      @event = Event.find(params[:event_id])
      be.each do |q|
        @event.book_events.create(
          event_id: @event.id,
          book_id:  q[1]["book_id"])
      end
      redirect_to admin_event_path(@event)
    when "book"
      @book = Book.find(params[:book_id])
      be.each do |q|
        @book.book_events.create(
          event_id: q[1]["event_id"],
          book_id:  @book.id)
      end
      redirect_to admin_book_path(@book)
    end
  end

  def delete
    @book_event = BookEvent.find(params[:book_event_id])
    event       = @book_event.event
    book        = @book_event.book

    @book_event.destroy

    case params[:redirection]
    when "event"
      redirect_to admin_event_path(event)
    when "book"
      redirect_to admin_book_path(book)
    end
  end

  def book_event_params
    params.require(:book_event).permit(
      :book_id,
      :event_id)
  end
end