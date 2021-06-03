class PeopleController < ApplicationController
  def show
    @person = Person.find(params[:id])
    @documents = @person.documents

    # Images
    image_formats = ["png", "jpg", "jpeg", "tiff"]
    @images = @documents.select {|d| image_formats.include?(d.format) }

    # Texts
    text_formats = ["pdf", "txt", "doc", "docx"]
    @texts = @documents.select {|d| text_formats.include?(d.format) }
  end

  def index
    @people = Person.all
    @people = @people.order(created_at: :desc).page params[:page]
  end

  def new
    @person = Person.new
    @person.a_links.build
  end

  def create
    @person = Person.create(person_params)
    links = params.as_json["person"]["family_links_attributes"]
    links.each do |l|
      person_b = Person.find(l[1]["person_b_id"])
      link_b_to_a = l[1]["link_b_to_a"]
      link_a_to_b = reciprocal_link(link_b_to_a, @person.gender)

      @person.a_links.create(
        person_a_id: @person.id,
        person_b_id: person_b.id,
        link_a_to_b: link_a_to_b,
        link_b_to_a: link_b_to_a)
    end
    redirect_to people_path
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
      :notes)
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