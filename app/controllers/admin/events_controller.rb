class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!
  def search
    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # Events
      name    = Event.arel_table[:name]
      story   = Event.arel_table[:story]
      comment = Event.arel_table[:comment]
      @events = Event.where(name.matches("%#{@keywords}%")).or(
                Event.where(story.matches("%#{@keywords}%"))).or(
                Event.where(comment.matches("%#{@keywords}%"))
      )
    end
    @events = @events.order(created_at: :desc).page params[:page]
    render "admin/events/index"
  end

  def show
    @event            = Event.find(params[:id])
    @documents        = @event.documents
    @event_documents  = @event.event_documents
    @people           = @event.people
  end

  def index
    @events = Event.all
    @events = @events.order(created_at: :desc).page params[:page]
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    redirect_to admin_event_path(@event)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to admin_event_path(@event)
  end

  def event_params
    params.require(:event).permit(
      :name,
      :date_start,
      :date_end,
      :story,
      :comment,
      :illustration,
      :privacy)
  end
end
