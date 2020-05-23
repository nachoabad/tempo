class Admin::SlotsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_slot, only: [:destroy]
  before_action :set_service, only: [:new, :create]

  def new
    @slot = Slot.new
  end

  def create
    @slot = @service.slots.new(slot_params)

    if @slot.save
      redirect_to admin_service_events_path(@slot.service), notice: 'Nuevo horario creado'
    else
      render :new
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
    def set_slot
      @slot = @service.slots.find(params[:id])
    end

    def set_service
      @service = current_admin.services.find(params[:service_id])
    end

    def slot_params
      params.require(:slot).permit(:day, :hour, :min)
    end
end
