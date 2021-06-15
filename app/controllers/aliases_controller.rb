class AliasesController < ApplicationController
  def new
    @alias = Alias.new()
    @person = Person.find(params[:person_id])
  end

  def create
    @person = Person.find(params[:person_id])
    al = params.as_json["alias"]
    al.each do |a|
      category = a[1]["category"]
      name = a[1]["name"]

      @person.aliases.create(
        category: category,
        name: name,
        person_id: @person.id)
    end
    redirect_to admin_person_path(@person)
  end
end