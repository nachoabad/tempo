class Admin::BlockersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_service, only: [:index, :new, :create]

  def new
    @blocker_params = blocker_params
  end

  def create
    slot = current_admin.slots.find params[:event][:slot_id]
    @event = slot.events.new(event_params)
    @event.blocked!

    respond_to do |format|
      if @event.save
        format.html { redirect_to admin_service_events_path(@service), notice: 'Bloqueo éxitoso' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
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
    def set_service
      @service = current_admin.services.find(params[:service_id])
    end

    def blocker_params
      params.permit(:date, :week, :slot)
    end
end
