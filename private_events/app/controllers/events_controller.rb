class EventsController < ApplicationController
  # user must be logged in to create an event 

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build description: params[:event][:description]
    if @event.save
      redirect_to event_path(@event)
    else
      flash.now[:error] = "Event could not be created"
      render new_event_path
    end
  end

  def show
    @event = Event.find params[:id]
  end

end