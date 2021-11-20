class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])

    # Filter if person is private and user should not have access
    private_access = user_signed_in? && current_user.has_private_access
    if @person.privacy && !private_access
      redirect_to private_content_path
    end

    @documents  = @person.documents
    @a_links    = @person.a_links
    @b_links    = @person.b_links
    @links      = @a_links + @b_links
    @aliases    = @person.aliases
    @events     = @person.events

    # Images
    image_formats = ["gif", "png", "jpg", "jpeg", "tiff"]
    @images = @documents.select {|d| image_formats.include?(d.format) }

    # Texts
    @texts = @documents.select {|d| image_formats.exclude?(d.format) }
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