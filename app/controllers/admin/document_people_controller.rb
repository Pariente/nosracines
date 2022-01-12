class Admin::DocumentPeopleController < ApplicationController
  before_action :authenticate_admin!
  def new
    @document_person = DocumentPerson.new()

    case params[:from]
    when "document"
      @document = Document.find(params[:document_id])
    when "person"
      @person = Person.find(params[:person_id])
    end
  end

  def create
    dp = params.as_json["document_person"]

    case dp["from"]
    when "document"
      @document = Document.find(params[:document_id])
      dp.each do |q|
        unless DocumentPerson.exists?(
            document_id:  @document.id,
            person_id:    q[1]["person_id"])
          @document.document_people.create(
            document_id:  @document.id,
            person_id:    q[1]["person_id"])
        end
      end
      redirect_to admin_document_path(@document)
    when "person"
      @person = Person.find(params[:person_id])
      dp.each do |q|
        unless DocumentPerson.exists?(
            document_id:  q[1]["document_id"],
            person_id:    @person.id)
          @person.document_people.create(
            document_id:  q[1]["document_id"],
            person_id:    @person.id)
        end
      end
      redirect_to admin_person_path(@person)
    end
  end

  def delete
    @document_person  = DocumentPerson.find(params[:document_person_id])
    document          = @document_person.document
    person            = @document_person.person

    @document_person.destroy

    case params[:redirection]
    when "document"
      redirect_to admin_document_path(document)
    when "person"
      redirect_to admin_person_path(person)
    end
  end

  def document_person_params
    params.require(:document_person).permit(
      :person_id,
      :document_id)
  end
end