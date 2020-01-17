class EventsController < ApplicationController    
  before_action :user_logged_in? , only: [:create]

  def index
    @prev_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def create
    @event = current_user.hosted_events.build event_params 
    @event.save
    redirect_to @event
  end
  
  private
  
  def event_params
    params.require(:event).permit(:description, :date)
  end
end
