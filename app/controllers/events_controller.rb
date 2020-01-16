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
  end
end
