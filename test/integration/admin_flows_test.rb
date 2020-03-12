require 'test_helper'

class AdminFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "can login and logout" do
    get admin_root_path   
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    assert_select "h2", "Log in"

    post admin_session_path,
      params: { admin: { email: 'admin2@mail.com', password: 'adminadmin' } }
    follow_redirect!
    assert_select "a", "Logout"

    delete destroy_admin_session_path
    follow_redirect!
    assert_select "h2", "Log in"
  end

  test 'can see slots and events' do
    sign_in admins(:two)

    get admin_service_events_path(services(:b))

    assert_select 'a', '8:11'
    assert_select 'a', '8:12'
    assert_select 'a', '8:13'
  end
end