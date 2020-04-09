class FreeTrialsController < ApplicationController
  before_action :set_free_trial, only: [:show, :edit, :update, :destroy]

  # GET /free_trials
  # GET /free_trials.json
  def index
    @free_trials = FreeTrial.all
  end

  # GET /free_trials/1
  # GET /free_trials/1.json
  def show
  end

  # GET /free_trials/new
  def new
    @free_trial = FreeTrial.new
  end

  # GET /free_trials/1/edit
  def edit
  end

  # POST /free_trials
  # POST /free_trials.json
  def create
    @free_trial = FreeTrial.new(free_trial_params)

    respond_to do |format|
      if @free_trial.save
        FreeTrialMailer.with(free_trial: @free_trial).new_email.deliver_later
        format.html { redirect_to root_path, notice: 'Hemos recibido tus datos. Pronto serás contactado.' }
        format.json { render :show, status: :created, location: @free_trial }
      else
        format.html { render :new }
        format.json { render json: @free_trial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /free_trials/1
  # PATCH/PUT /free_trials/1.json
  def update
    respond_to do |format|
      if @free_trial.update(free_trial_params)
        format.html { redirect_to @free_trial, notice: 'Free trial was successfully updated.' }
        format.json { render :show, status: :ok, location: @free_trial }
      else
        format.html { render :edit }
        format.json { render json: @free_trial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /free_trials/1
  # DELETE /free_trials/1.json
  def destroy
    @free_trial.destroy
    respond_to do |format|
      format.html { redirect_to free_trials_url, notice: 'Free trial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_free_trial
      @free_trial = FreeTrial.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def free_trial_params
      params.require(:free_trial).permit(:name, :phone, :email, :contact_time)
    end
end
