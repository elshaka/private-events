class EventsController < ApplicationController
  before_action :user_logged_in?, only: %i[new create join leave]
  before_action :this_event, only: %i[join leave show]

  def index
    @prev_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show; end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.hosted_events.build event_params
    if @event.save
      flash[:success] = 'Event created successfully'
      redirect_to @event
    else
      render :new
    end
  end

  def join
    if current_user.join_event @event
      flash[:success] = "You're now attending this event"
    else
      flash[:warning] = "You're already attending this event"
    end
    redirect_to @event
  end

  def leave
    if current_user.leave_event @event
      flash[:success] = "You're no longer attending this event"
    else
      flash[:warning] = "You weren't attending this event"
    end
    redirect_to @event
  end

  private

  def this_event
    @event = Event.find_by(id: params[:id])
    return if @event

    flash[:warning] = "The event doesn't exist"
    redirect_to :root
  end

  def event_params
    params.require(:event).permit(:description, :date)
  end
end
