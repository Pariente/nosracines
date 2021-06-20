class Admin::PeopleController < ApplicationController
  def search
    @params = params["search"]
    if @params.present?
      @keywords = @params[:keywords]

      # People
      first_name  = Person.arel_table[:first_name]
      middle_name = Person.arel_table[:middle_name]
      last_name   = Person.arel_table[:last_name]
      spouse_name = Person.arel_table[:spouse_name]
      @people = Person.where(first_name.matches("%#{@keywords}%")).or(
                Person.where(middle_name.matches("%#{@keywords}%"))).or(
                Person.where(last_name.matches("%#{@keywords}%"))).or(
                Person.where(spouse_name.matches("%#{@keywords}%"))
      )
    end
    @people = @people.order(created_at: :desc).page params[:page]
    render "admin/people/index"
  end

  def show
    @person = Person.find(params[:id])
    @documents = @person.documents
    @a_links = @person.a_links
    @b_links = @person.b_links
    @links = @a_links + @b_links
    @aliases = @person.aliases
  end

  def index
    @people = Person.all
    @people = @people.order(created_at: :desc).page params[:page]
  end

  def new
    @person = Person.new
    @person.a_links.build
    @person.aliases.build
  end

  def create
    @person = Person.create(person_params)
    redirect_to admin_person_path(@person)
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    @person.update(person_params)
    redirect_to admin_person_path(@person)
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
