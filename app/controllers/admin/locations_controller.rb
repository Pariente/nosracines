class Admin::LocationsController < ApplicationController
  before_action :authenticate_admin!
  def search
    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # Locations
      name        = Location.arel_table[:name]
      address     = Location.arel_table[:address]
      city        = Location.arel_table[:city]
      zipcode     = Location.arel_table[:zipcode]
      region      = Location.arel_table[:region]
      country     = Location.arel_table[:country]
      description = Location.arel_table[:description]
      latitude    = Location.arel_table[:latitude]
      longitude   = Location.arel_table[:longitude]
      @locations  = Location.where(name.matches("%#{@keywords}%")).or(
                    Location.where(address.matches("%#{@keywords}%"))).or(
                    Location.where(city.matches("%#{@keywords}%"))).or(
                    Location.where(zipcode.matches("%#{@keywords}%"))).or(
                    Location.where(region.matches("%#{@keywords}%"))).or(
                    Location.where(country.matches("%#{@keywords}%"))).or(
                    Location.where(description.matches("%#{@keywords}%"))).or(
                    Location.where(latitude.matches("%#{@keywords}%"))).or(
                    Location.where(longitude.matches("%#{@keywords}%"))
      )
    end
    @locations = @locations.order(created_at: :desc).page params[:page]
    render "admin/locations/index"
  end

  def show
    @location            = Location.find(params[:id])
    @location_documents  = @location.location_documents
    @location_events     = @location.location_events
    @location_people     = @location.location_people
  end

  def index
    @locations = Location.all
    @locations = @locations.order(created_at: :desc).page params[:page]
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.create(location_params)
    redirect_to admin_location_path(@location)
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to admin_location_path(@location)
  end

  def location_params
    params.require(:location).permit(
      :name,
      :illustration,
      :address,
      :city,
      :zipcode,
      :region,
      :country,
      :latitude,
      :longitude,
      :description,
      :privacy)
  end
end
