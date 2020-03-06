class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_slot, only: [:new, :create]
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = current_user.events
  end

  def show
  end

  def new
    @date = params[:date].to_date
    @event = @slot.events.new
  end

  def edit
  end

  def create
    @event = current_user.events.new(event_params.merge slot: @slot)

    respond_to do |format|
      if @event.save
        format.html { redirect_to events_path, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_slot
      @slot = Slot.find(params[:slot_id])
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:date, :note)
    end
end
