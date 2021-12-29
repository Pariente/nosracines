class DocumentsController < ApplicationController
  def show
    @search_bar = true
    @document = Document.find(params[:id])

    # Filter if doc is private and user should not have access
    private_access = user_signed_in? && current_user.has_private_access
    if @document.privacy && !private_access
      redirect_to private_content_path
    end

    @people     = @document.people
    @events     = @document.events
    @locations  = @document.locations

    # Filter access-restricted contents if the user should not have access to them
    unless private_access
      @people     = @people.select {|p| !p.privacy?}
      @events     = @events.select {|e| !e.privacy?}
      @locations  = @locations.select {|l| !l.privacy?}
    end

    @document_files = @document.document_files.order(created_at: :asc)
    unless params[:document_file].nil?
      @document_file = DocumentFile.find(params[:document_file])
    end
  end

  def search
    private_access = user_signed_in? && current_user.has_private_access

    case params[:category]
    when "Photographies"
      category = :images
    when "Documents"
      category = :texts
    when "Vidéos"
      category = :videos
    when "Audios"
      category = :audios
    when "Autres documents"
      category = :others
    end

    @documents = helpers.search_documents({ 
      keywords: params[:keywords], 
      private_access: private_access
    })[category]
    @documents = Kaminari.paginate_array(@documents).page(params[:page]).per(25)
  end

  def index
    private_access = user_signed_in? && current_user.has_private_access

    @category = params[:category]

    case @category
    when "Photographies"
      category = :images
    when "Textes"
      category = :texts
    when "Films"
      category = :videos
    when "Audios"
      category = :audios
    when "Documents"
      category = :documents
    end

    @documents = helpers.search_documents({ 
      keywords: params[:keywords], 
      private_access: private_access
    })[category]
    @documents = Kaminari.paginate_array(@documents).page(params[:page]).per(24)
  end
end