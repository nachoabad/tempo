class Admin::SlotsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_slot, only: [:destroy]
  before_action :set_service, only: [:new, :create]

  def new
    @slot = Slot.new
  end

  def create
    @slot = @service.slots.new(slot_params.merge(status: 1))

    if @slot.save
      redirect_to admin_service_events_path(@slot.service), notice: 'Nuevo horario creado'
    else
      render :new
    end
  end

  def destroy
    @slot.destroy
    redirect_to admin_service_events_path(@slot.service), notice: 'Horario eliminado'
  end

  private
    def set_slot
      @slot = current_admin.slots.find(params[:id])
    end

    def set_service
      @service = current_admin.services.find(params[:service_id])
    end

    def slot_params
      params.require(:slot).permit(:day, :hour, :min)
    end
end
