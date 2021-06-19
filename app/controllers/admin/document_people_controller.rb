class Admin::DocumentPeopleController < ApplicationController
  def new
    @document_person = DocumentPerson.new()
    @document = Document.find(params[:document_id])
  end

  def create
    @document = Document.find(params[:document_id])
    dp = params.as_json["document_person"]
    dp.each do |d|
      @document.document_people.create(
        person_id:    d[1]["person_id"],
        document_id:  @document_id)
    end
    redirect_to admin_document_path(@document)
  end

  def delete
    @document_person = DocumentPerson.find(params[:document_person_id])
    document = @document_person.document
    @document_person.destroy
    redirect_to admin_document_path(document)
  end

  def document_person_params
    params.require(:document_person).permit(
      :person_id,
      :document_id)
  end
end