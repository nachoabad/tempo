class ApplicationController < ActionController::Base
  before_action :set_service_id

  private

  def set_service_id
    @service_id = cookies[:service_id] || current_user.events.last.service.id if current_user
  end
end
