class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])

    # Assess if the user has access to private content
    private_access = user_signed_in? && current_user.has_private_access
    
    # If the resource is private and user should have access to it
    if @person.privacy && !private_access
      redirect_to private_content_path
    end

    @documents  = @person.documents
    @a_links    = @person.a_links
    @b_links    = @person.b_links
    @links      = @a_links + @b_links
    @aliases    = @person.aliases
    @events     = @person.events
    @locations  = @person.locations

    # Filter access-restricted contents if the user should not have access to them
    unless private_access
      @documents  = @documents.select {|d| !d.privacy?}
      @events     = @events.select {|e| !e.privacy?}
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

  def index
    @people = Person.all
    @people = @people.order(created_at: :desc).page params[:page]
  end

  def person_params
    params.require(:person).permit(
      :first_name,
      :last_name,
      :middle_name,
      :spouse_name,
      :birth_date,
      :death_date,
      :profile_pic,
      :biography,
      :gender,
      :birth_place,
      :death_place,
      :notes,
      :privacy)
  end

  def reciprocal_link(link, gender_a)
    link_matches = {
      "Épouse" =>     ["Époux", "Époux"],
      "Époux" =>      ["Épouse", "Épouse"],
      "Mère" =>       ["Fille", "Fils"],
      "Père" =>       ["Fille", "Fils"],
      "Sœur" =>       ["Sœur", "Frère"],
      "Frère" =>      ["Sœur", "Frère"],
      "Fille" =>      ["Mère", "Père"],
      "Fils" =>       ["Mère", "Père"],
      "Cousine" =>    ["Cousine", "Cousin"],
      "Cousin" =>     ["Cousine", "Cousin"],
      "Tante" =>      ["Nièce", "Neveu"],
      "Oncle" =>      ["Nièce", "Neveu"],
      "Nièce" =>      ["Tante", "Oncle"],
      "Neveu" =>      ["Tante", "Oncle"],
      "Grand-mère" => ["Petite-fille", "Petit-fils"],
      "Grand-père" => ["Petite-fille", "Petit-fils"]
    }

    return link_matches[link][gender_a.to_i]
  end
end