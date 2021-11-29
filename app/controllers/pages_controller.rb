class PagesController < ApplicationController
  def home
  end

  def private_content
  end

  def search
    # Does the user has access to private content?
    private_access = user_signed_in? && current_user.has_private_access

    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # People
      first_name  = Person.arel_table[:first_name]
      middle_name = Person.arel_table[:middle_name]
      last_name   = Person.arel_table[:last_name]
      spouse_name = Person.arel_table[:spouse_name]
      @people     = Person.where(first_name.matches("%#{@keywords}%")).or(
                    Person.where(middle_name.matches("%#{@keywords}%"))).or(
                    Person.where(last_name.matches("%#{@keywords}%"))).or(
                    Person.where(spouse_name.matches("%#{@keywords}%"))
      )
      # Filter if user should not access private content
      unless private_access
        @people = @people.select {|p| !p.privacy}
      end

      # Documents
      name        = Document.arel_table[:name]
      @documents  = Document.where(name.matches("%#{@keywords}%"))
      
      people_docs = []
      @people.each do |p|
        people_docs += p.documents
      end
      @documents += people_docs
      @documents = @documents.uniq

      # Events
      name    = Event.arel_table[:name]
      @events = Event.where(name.matches("%#{@keywords}%"))

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
        @documents  = @documents.select {|d| !d.privacy}
        @events     = @events.select {|e| !e.privacy}
        @locations  = @locations.select {|l| !l.privacy}
      end

      # Images
      image_formats = ["gif", "png", "jpg", "jpeg", "tif", "tiff", "heic", "svg"]
      @images       = @documents.select {|d| image_formats.include?(d.format) }

      # Videos
      video_formats = ["avi", "mov", "mp4", "wav", "wma", "wmv"]
      @videos       = @documents.select {|d| video_formats.include?(d.format) }

      # Audios
      audio_formats = ["mid", "mp3"]
      @audios       = @documents.select {|d| audio_formats.include?(d.format) }
      
      # Texts
      text_formats = ["doc", "docx", "pdf", "txt"]
      @texts = @documents.select {|d| text_formats.include?(d.format) }

      # Others
      all_formats = image_formats + video_formats + audio_formats + text_formats
      @others = @documents.select {|d| all_formats.exclude?(d.format) }
    end
  end
end