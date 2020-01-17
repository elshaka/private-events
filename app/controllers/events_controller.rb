class EventsController < ApplicationController    
  before_action :user_logged_in? , only: [:new, :create, :join, :leave]

  before_action :get_event, only: [:join, :leave, :show]
  
  def index
    @prev_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show
  end

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
    current_user.attending_events << @event
    redirect_to @event
  end

  def leave
    current_user.attending_events.delete @event
    redirect_to @event
  end

  private

  def get_event
    @event = Event.find_by(id: params[:id])
  end

  def event_params
    params.require(:event).permit(:description, :date)
  end
end
