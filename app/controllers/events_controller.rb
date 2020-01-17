class EventsController < ApplicationController
  before_action :user_logged_in? , only: [:new, :create]

  def index
    @prev_events = Event.past
    @upcoming_events = Event.upcoming
  end

  def show
    @event = Event.find_by(id: params[:id])
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

  private

  def event_params
    params.require(:event).permit(:description, :date)
  end
end
