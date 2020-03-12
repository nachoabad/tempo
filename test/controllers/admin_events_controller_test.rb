require 'test_helper'

class AdminEventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in admins(:one)
  end

  test "should get index" do
    get admin_service_events_url(services(:one))
    assert_response :success
  end
end
