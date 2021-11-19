class PagesController < ApplicationController
  def home
  end

  def private_content
  end

  def search
    # Does the user has access to private content?
    private_access = user_signed_in? && current_user.has_private_access

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
      # Filter if user should not access private content
      unless private_access
        @people = @people.select {|p| !p.privacy}
      end

      # Documents
      name = Document.arel_table[:name]
      @documents =  Document.where(name.matches("%#{@keywords}%"))
      
      people_docs = []
      @people.each do |p|
        people_docs += p.documents
      end
      @documents += people_docs
      @documents = @documents.uniq

      # Filter if user should access private content
      unless private_access
        @documents = @documents.select {|d| !d.privacy}
      end

      # Images
      image_formats = ["gif", "png", "jpg", "jpeg", "tiff"]
      @images = @documents.select {|d| image_formats.include?(d.format) }

      # Texts
      @texts = @documents.select {|d| image_formats.exclude?(d.format) }
    end
  end
end