class Admin::FamilyLinksController < ApplicationController
  def new
    @family_link = FamilyLink.new()
    @person = Person.find(params[:person_id])
  end

  def create
    @person = Person.find(params[:person_id])
    links = params.as_json["family_links"]
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
    redirect_to admin_person_path(@person)
  end

  def delete
    @fam_link = FamilyLink.find(params[:family_link_id])
    person = Person.find(params[:person_id])
    @fam_link.destroy
    redirect_to admin_person_path(person)
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