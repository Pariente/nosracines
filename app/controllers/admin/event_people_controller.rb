class Admin::EventPeopleController < ApplicationController
  before_action :authenticate_admin!
  def new
    @event_person = EventPerson.new()
    @person = Person.find(params[:person_id])
  end

  def create
    @person = Person.find(params[:person_id])
    ep      = params.as_json["event_person"]
    ep.each do |e|
      @person.event_people.create(
        person_id:  @person_id,
        event_id:   e[1]["event_id"])
    end
    redirect_to admin_person_path(@person)
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