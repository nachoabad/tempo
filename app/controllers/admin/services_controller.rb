class Admin::ServicesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @services = current_admin.services
    redirect_to admin_service_events_path(@services.first) if @services.count == 1
  end
end
