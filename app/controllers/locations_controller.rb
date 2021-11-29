class LocationsController < ApplicationController
  def index
    @locations = Location.all
    @locations = @locations.order(created_at: :desc).page params[:page]
  end

  def show
    @search_bar = true
    @location = Location.find(params[:id])

    # Assess if the user has access to private content
    private_access = user_signed_in? && current_user.has_private_access
    
    # If the resource is private and user should have access to it
    if @location.privacy && !private_access
      redirect_to private_content_path
    end

    @documents  = @location.documents
    @events     = @location.events
    @people     = @location.people

    # Filter access-restricted contents if the user should not have access to them
    unless private_access
      @documents  = @documents.select {|d| !d.privacy?}
      @events     = @events.select {|e| !e.privacy?}
      @people     = @people.select {|p| !p.privacy?}
    end

    # Images
    image_formats = ["gif", "png", "jpg", "jpeg", "tiff", "heic", "svg"]
    @images       = @documents.select {|d| image_formats.include?(d.format) }

    # Videos
    video_formats = ["avi", "mov", "mp4", "wav", "wma", "wmv"]
    @videos       = @documents.select {|d| video_formats.include?(d.format) }

    # Audios
    audio_formats = ["mid", "mp3"]
    @videos       = @documents.select {|d| video_formats.include?(d.format) }
    
    # Texts
    text_formats  = ["doc", "docx", "pdf", "txt"]
    @texts        = @documents.select {|d| text_formats.include?(d.format) }

    # Others
    all_formats = image_formats + video_formats + audio_formats + text_formats
    @other      = @documents.select {|d| all_formats.exclude?(d.format) }
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