class Admin::BlockersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_service_slot_blocker

  def new
    @blocker_params = blocker_params
  end

  def block
    if @slot_blocker.block!
      redirect_to admin_service_events_path(@service), notice: 'Bloqueo éxitoso'
    else
      # handle errors
    end
  end

  def unblock
    if @slot_blocker.unblock!
      redirect_to admin_service_events_path(@service), notice: 'Desbloqueo éxitoso'
    else
      # handle errors
    end
  end

  private
    def set_service_slot_blocker
      @service = current_admin.services.find(params[:service_id])
      @slot_blocker = SlotBlocker.new(blocker_params: blocker_params,
                                      service: @service)
    end

    def blocker_params
      params.permit(:week, :date, :slot)
    end
end
