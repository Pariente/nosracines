class PagesController < ApplicationController
  def home
    @events = Event.where(
      "to_char(date_start, 'MM') || to_char(date_start, 'DD') between ? and ?",
      '%2.2d%2.2d' % [Date.today.month, Date.today.day],
      '%2.2d%2.2d' % [Date.today.month, Date.today.day]
    )

    @people = Person.where(
      "to_char(birth_date, 'MM') || to_char(birth_date, 'DD') between ? and ?",
      '%2.2d%2.2d' % [Date.today.month, Date.today.day],
      '%2.2d%2.2d' % [Date.today.month, Date.today.day]
    )
  end

  def private_content
    @search_bar = true
  end

  def search
    # Does the user has access to private content?
    private_access = user_signed_in? && current_user.has_private_access

    @params = params["search"]

    @documents  = []
    @images     = []
    @audios     = []
    @videos     = []
    @texts      = []
    @others     = []
    @events     = []
    @locations  = []
    @people     = []

    if @params.present?
      @keywords = @params[:keywords]
      
      # People
      search_people = helpers.search_people({
                        keywords: @keywords, 
                        private_access: private_access,
                        limit: 12
                      })
      @people       = search_people[:people]
      @people_count = search_people[:count]

      # Documents
      search_documents = helpers.search_documents({
        keywords: @keywords,
        private_access: private_access,
        limit: 12
      })

      @images       = search_documents[:images]
      @audios       = search_documents[:audios]
      @videos       = search_documents[:videos]
      @texts        = search_documents[:texts]
      @others       = search_documents[:others]
      @images_count = search_documents[:images_count]
      @audios_count = search_documents[:audios_count]
      @videos_count = search_documents[:videos_count]
      @texts_count  = search_documents[:texts_count]
      @others_count = search_documents[:others_count]

      # Events
      search_events = helpers.search_events({
                        keywords: @keywords, 
                        private_access: private_access,
                        limit: 12
                      })
      @events       = search_events[:events]
      @events_count = search_events[:count]

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

      # Filter if user should access private content
      unless private_access
        @locations  = @locations.select {|l| !l.privacy}
      end
    end
  end
end