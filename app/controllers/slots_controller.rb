class SlotsController < ApplicationController
  before_action :set_service, only: [:index]
  before_action :set_slot, only: [:show, :edit, :update, :destroy]

  def index
    date = params[:date].try(:to_date) || Date.today
    @soonest_date  = @service.soonest_available_date(date)
    @next_date     = @service.soonest_available_date(@soonest_date + 1)
    @previous_date = @service.latest_available_date(@soonest_date - 1)
    @slots         = @service.slots.for_date(@soonest_date)
  end

  def show
  end

  def new
    @slot = Slot.new
  end

  def edit
  end

  # POST /slots
  # POST /slots.json
  def create
    @slot = Slot.new(slot_params)

    respond_to do |format|
      if @slot.save
        format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
        format.json { render :show, status: :created, location: @slot }
      else
        format.html { render :new }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /slots/1
  # PATCH/PUT /slots/1.json
  def update
    respond_to do |format|
      if @slot.update(slot_params)
        format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
        format.json { render :show, status: :ok, location: @slot }
      else
        format.html { render :edit }
        format.json { render json: @slot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.json
  def destroy
    @slot.destroy
    respond_to do |format|
      format.html { redirect_to slots_url, notice: 'Slot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_service
      @service = Service.find(params[:service_id])
    end

    def set_slot
      @slot = Slot.find(params[:id])
    end

    def slot_params
      params.require(:slot).permit(:day, :hour, :min, :zone, :status, :service_id)
    end
end
