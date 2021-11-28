class Admin::LocationEventsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @location_event = LocationEvent.new()

    case params[:from]
    when "location"
      @location = Location.find(params[:location_id])
    when "event"
      @event = Event.find(params[:event_id])
    end
  end

  def create
    le = params.as_json["location_event"]

    case le["from"]
    when "location"
      @location = Location.find(params[:location_id])
      le.each do |q|
        @location.location_events.create(
          location_id:  @location.id,
          event_id:     q[1]["event_id"])
      end
      redirect_to admin_location_path(@location)
    when "event"
      @event = Event.find(params[:event_id])
      le.each do |q|
        @event.location_events.create(
          location_id:  q[1]["location_id"],
          event_id:     @event.id)
      end
      redirect_to admin_event_path(@event)
    end
  end

  def delete
    @location_event = LocationEvent.find(params[:location_event_id])
    location        = @location_event.location
    event           = @location_event.event

    @location_event.destroy

    case params[:redirection]
    when "location"
      redirect_to admin_location_path(location)
    when "event"
      redirect_to admin_event_path(event)
    end
  end

  def location_event_params
    params.require(:location_event).permit(
      :location_id,
      :event_id)
  end
end