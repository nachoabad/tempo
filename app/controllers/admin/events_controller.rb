class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_service, only: [:index]

  def index
    date = params[:date].try(:to_date) || Date.today
    @week_start = date.beginning_of_week
    @slots = @service.slots
    @events = @service.events
  end

  def show
  end

  def new
    @event = Event.new
    @date = params[:date]
    @slot = current_admin.slots.find params[:slot]
  end

  def edit
  end

  def create
    slot = current_admin.slots.find params[:event][:slot_id]
    @event = slot.events.new(event_params)
    @event.blocked!

    respond_to do |format|
      if @event.save
        format.html { redirect_to admin_service_events_path(@event.service), notice: 'Event was successfully blocked.' }
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
      format.html { redirect_to admin_service_events_path(@event.service), notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = current_admin.events.find(params[:id])
    end

    def set_service
      @service = current_admin.services.find(params[:service_id])
    end

    def event_params
      params.require(:event).permit(:date)
    end
end
