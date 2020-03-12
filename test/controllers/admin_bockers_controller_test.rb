require 'test_helper'

class AdminBlockersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in admins(:one)
  end

  test "should get new" do
    get new_admin_service_blocker_url(services(:one))
    assert_response :success
  end

  test "should block slots" do
    assert_difference('Event.count', 1) do
      post block_admin_service_blockers_url(services(:one)), params: { date: Date.today, note: 'note' }
    end

    assert_redirected_to admin_service_events_url(services(:one))
  end

  test "should unblock slots" do
    assert_difference('Event.count', 0) do
      post unblock_admin_service_blockers_url(services(:one)), params: { date: Date.today, note: 'note' }
    end

    assert_redirected_to admin_service_events_url(services(:one))
  end
end
