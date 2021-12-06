module SearchHelper
  def search_people(params)
    keywords        = params[:keywords]
    private_access  = params[:private_access]
    limit           = params[:limit]

    first_name  = Person.arel_table[:first_name]
    middle_name = Person.arel_table[:middle_name]
    last_name   = Person.arel_table[:last_name]
    spouse_name = Person.arel_table[:spouse_name]
    people      = Person.where(first_name.matches("%#{keywords}%")).or(
                  Person.where(middle_name.matches("%#{keywords}%"))).or(
                  Person.where(last_name.matches("%#{keywords}%"))).or(
                  Person.where(spouse_name.matches("%#{keywords}%"))
    )

    # Filter if user should not access private content
    unless private_access
      people = people.select {|p| !p.privacy}
    end

    # Alias
    alias_name    = Alias.arel_table[:name]
    aliases       = Alias.where(alias_name.matches("%#{keywords}%"))
    alias_people  = []
    aliases.each do |q|
      alias_people << q.person
    end

    people  += alias_people
    people  = people.uniq
    count   = people.count

    unless limit.nil?
      people = people.first(limit)
    end

    return {people: people, count: count}
  end

  def search_documents(params)
    keywords        = params[:keywords]
    private_access  = params[:private_access]
    limit           = params[:limit]

    people =  search_people({ 
                keywords: keywords, 
                private_access: private_access
              })[:people]

    name      = Document.arel_table[:name]
    documents = Document.where(name.matches("%#{keywords}%"))
    
    people_docs = []
    people.each do |p|
      people_docs += p.documents
    end

    documents += people_docs
    documents = documents.uniq
    count     = documents.count

    unless private_access
      documents  = documents.select {|d| !d.privacy}
    end

    # Images
    image_formats = ["gif", "png", "jpg", "jpeg", "tif", "tiff", "heic", "svg"]
    images        = documents.select {|d| image_formats.include?(d.format) }
    images_count  = images.count

    # Videos
    video_formats = ["avi", "mov", "mp4", "wav", "wma", "wmv"]
    videos        = documents.select {|d| video_formats.include?(d.format) }
    videos_count  = videos.count

    # Audios
    audio_formats = ["mid", "mp3"]
    audios        = documents.select {|d| audio_formats.include?(d.format) }
    audios_count  = audios.count
    
    # Texts
    text_formats  = ["doc", "docx", "pdf", "txt"]
    texts         = documents.select {|d| text_formats.include?(d.format) }
    texts_count   = texts.count

    # Others
    all_formats   = image_formats + video_formats + audio_formats + text_formats
    others        = documents.select {|d| all_formats.exclude?(d.format) }
    others_count  = others.count

    unless limit.nil?
      documents = documents.first(limit)
      images    = images.first(limit)
      videos    = videos.first(limit)
      audios    = audios.first(limit)
      texts     = texts.first(limit)
      others    = others.first(limit)
    end

    return {
      images:       images,
      audios:       audios,
      videos:       videos,
      texts:        texts,
      others:       others,
      images_count: images_count,
      audios_count: audios_count,
      videos_count: videos_count,
      texts_count:  texts_count,
      others_count: others_count
    }
  end

  def search_events(params)
    keywords        = params[:keywords]
    private_access  = params[:private_access]
    limit           = params[:limit]

    name    = Event.arel_table[:name]
    events  = Event.where(name.matches("%#{keywords}%"))

    # Filter if user should not access private content
    unless private_access
      events = events.select {|e| !e.privacy}
    end

    events_count = events.count

    unless limit.nil?
      events = events.first(limit)
    end

    return {events: events, count: events_count}
  end
end