require 'test_helper'

class AdminServicesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in admins(:one)
  end

  test "should redirect to first service events index if admin has only one service" do
    get admin_services_url
    assert_redirected_to admin_service_events_path(admins(:one).services.first)
  end
end
