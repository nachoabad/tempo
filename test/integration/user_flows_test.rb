require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "can register and logout" do
    get service_slots_path(services(:one))
    assert_response :redirect
    follow_redirect!
    assert_response :success
    
    get '/users/sign_up'
    assert_select "h2", "Sign up"

    post "/users",
      params: { user: { email: 'user+new@mail.com', password: 'useruser', password_confirmation: 'useruser' } }
    follow_redirect!
    assert_select "a", "Logout"
    
    delete destroy_user_session_path
    follow_redirect!
    assert_select "h2", "Log in"
  end

  test "can book a slot and unbook it" do
    get service_slots_path(services(:one))
    follow_redirect!
    assert_select "h2", "Log in"

    post user_session_path,
      params: { user: { email: users(:one).email, password: 'useruser' } }
    follow_redirect!
    assert_select 'h1', Date.today.to_s
    assert_select 'a', 'Next'
    assert_select "a", {count: 0, text: 'Back'}
    assert_select 'a', '8:0'

    get service_slots_path(services(:one), date: Date.tomorrow.to_s)
    assert_select 'h1', Date.tomorrow.to_s
    assert_select 'a', 'Next'
    assert_select "a", 'Back'
    assert_select 'a', '8:0'

    get new_slot_event_path(slots(:tomorrow_8am), date: Date.tomorrow.to_s)
    assert_select 'h1', "New Event #{Date.tomorrow.to_s}"

    post slot_events_path(slots(:tomorrow_8am)),
      params: { event: { date: Date.tomorrow, note: 'My Note' } }
    follow_redirect!

    assert_select 'p', 'Event was successfully created.'
    assert_select 'h1', 'Events'
    assert_select 'td', 'My Note'
    assert_select 'td', Date.tomorrow.to_s

    get service_slots_path(services(:one), date: Date.tomorrow.to_s)
    assert_select 'h1', (Date.today + 7).to_s

    delete event_path(slots(:tomorrow_8am).events.on_date(Date.tomorrow).first)
    follow_redirect!
    assert_select 'p', 'Event was successfully destroyed.'
    
    get service_slots_path(services(:one), date: Date.tomorrow.to_s)
    assert_select 'h1', Date.tomorrow.to_s
    assert_select 'a', 'Next'
    assert_select "a", 'Back'
    assert_select 'a', '8:0'
  end
end
