class EventsController < ApplicationController
  def show
    @search_bar = true
    @event = Event.find(params[:id])

    # Filter if person is private and user should not have access
    private_access = user_signed_in? && current_user.has_private_access
    if @event.privacy && !private_access
      redirect_to private_content_path
    end

    @documents  = @event.documents
    @people     = @event.people
    @locations  = @event.locations
  end

  def index
    @events = Event.all
    @events = @events.order(created_at: :desc).page params[:page]
  end

  def search
    private_access = user_signed_in? && current_user.has_private_access
    @events = helpers.search_events({ keywords: params[:keywords], 
                                      private_access: private_access}
                                    )[:events]
    @events = Kaminari.paginate_array(@events).page(params[:page]).per(25)
  end

  def event_params
    params.require(:person).permit(
      :name,
      :date_start,
      :date_end,
      :illustration,
      :story,
      :comment,
      :privacy)
  end
end