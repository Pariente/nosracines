class Admin::LocationPeopleController < ApplicationController
  before_action :authenticate_admin!
  def new
    @location_person = LocationPerson.new()

    case params[:from]
    when "location"
      @location = Location.find(params[:location_id])
    when "person"
      @person = Person.find(params[:person_id])
    end
  end

  def create
    lp = params.as_json["location_person"]

    case lp["from"]
    when "location"
      @location = Location.find(params[:location_id])
      lp.each do |q|
        @location.location_people.create(
          location_id:  @location.id,
          person_id:    q[1]["person_id"])
      end
      redirect_to admin_location_path(@location)
    when "person"
      @person = Person.find(params[:person_id])
      lp.each do |q|
        @person.location_people.create(
          location_id:  q[1]["location_id"],
          person_id:    @person.id)
      end
      redirect_to admin_person_path(@person)
    end
  end

  def delete
    @location_person  = LocationPerson.find(params[:location_person_id])
    location          = @location_person.location
    person            = @location_person.person

    @location_person.destroy

    case params[:redirection]
    when "location"
      redirect_to admin_location_path(location)
    when "person"
      redirect_to admin_person_path(person)
    end
  end

  def location_person_params
    params.require(:location_person).permit(
      :location_id,
      :person_id)
  end
end