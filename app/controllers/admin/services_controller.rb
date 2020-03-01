class Admin::ServicesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @services = current_admin.services
  end
end
