class PagesController < ApplicationController
  def home
  end

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

      # Documents
      name = Document.arel_table[:name]
      @documents =  Document.where(name.matches("%#{@keywords}%"))
      
      people_docs = []
      @people.each do |p|
        people_docs += p.documents
      end
      @documents += people_docs
      @documents = @documents.uniq

      # Images
      image_formats = ["gif", "png", "jpg", "jpeg", "tiff"]
      @images = @documents.select {|d| image_formats.include?(d.format) }

      # Texts
      @texts = @documents.select {|d| image_formats.exclude?(d.format) }
    end
  end
end