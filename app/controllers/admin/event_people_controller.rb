class Admin::EventPeopleController < ApplicationController
  before_action :authenticate_admin!
  def new
    @event_person = EventPerson.new()

    case params[:from]
    when "person"
      @person = Person.find(params[:person_id])
    when "event"
      @event = Event.find(params[:event_id])
    end
  end

  def create
    ep = params.as_json["event_person"]
    case ep["from"]
    when "person"
      @person = Person.find(params[:person_id])
      ep.each do |q|
        @person.event_people.create(
          person_id:  @person.id,
          event_id:   q[1]["event_id"])
      end
      redirect_to admin_person_path(@person)
    when "event"
      @event  = Event.find(params[:event_id])
      ep.each do |q|
        @event.event_people.create(
          person_id:  q[1]["person_id"],
          event_id:   @event.id)
      end
      redirect_to admin_event_path(@event)
    end
  end

  def delete
    @event_person = EventPerson.find(params[:event_person_id])
    person        = @event_person.person
    event         = @event_person.event
    
    @event_person.destroy

    case params[:redirection]
    when "event"
      redirect_to admin_event_path(event)
    when "person"
      redirect_to admin_person_path(person)
    end
  end

  def document_person_params
    params.require(:event_person).permit(
      :person_id,
      :event_id)
  end
end