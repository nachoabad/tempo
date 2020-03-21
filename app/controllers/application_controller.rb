class ApplicationController < ActionController::Base
  before_action :set_service

  private

  def set_service
    cookies[:service_id] = params[:service_id] if params[:service_id]

    id =  params[:service_id] ||
          cookies[:service_id] || 
          (current_user.events.last.service.id if current_user)

    @service = Service.find(id) if id
  end

  def after_sign_out_path_for(resource_or_scope)
    new_session_path(resource_name)
  end
end
