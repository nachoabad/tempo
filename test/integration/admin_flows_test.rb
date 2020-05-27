require 'test_helper'

class AdminFlowsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  test "can login and logout" do
    get admin_root_path   
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    assert_select "p", "o con tu email"

    post admin_session_path,
      params: { admin: { email: 'admin2@mail.com', password: 'adminadmin' } }
    follow_redirect!
    assert_select "a", "Salir"

    delete destroy_admin_session_path
    follow_redirect!
    assert_select "p", "o con tu email"
  end

  test 'can see slots and events' do
    sign_in admins(:two)

    get admin_service_events_path(services(:b))

    assert_select 'a', '8:11AM'
    assert_select 'a', '8:12AM'
    assert_select 'a', '8:13AM'
  end

  test 'can create a new slot' do
    sign_in admins(:two)

    get new_admin_service_slot_path(services(:b))
    assert_select 'h2', 'Nuevo Horario'

    assert_difference('Slot.count', 1) do
      post admin_service_slots_path(services(:b)),
        params: { slot: { day: 1, hour: 13, min: 45} }
    end
    follow_redirect!
    assert_select 'a', '1:45PM'
  end

end