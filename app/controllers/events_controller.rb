class EventsController < ApplicationController    
  before_action :user_logged_in? , only: [:create]

  def index
    @prev_events = Event.all
    @upcoming_events = Event.all
  end

  def show
    @event = Event.find_by(id: params[:id])
  end

  def create
    host = current_user
    attendance = Attendance.new
    attendance.user = host
    attendance.build_event description: params[:event][:description]
    attendance.event.host = host
    attendance.save
  end
end
