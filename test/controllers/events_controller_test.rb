require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test "should get new" do
    get new_slot_event_url(slots(:today_8am), date: Date.today)
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count', 1) do
      assert_emails 1 do
        post slot_events_url(slots(:today_8am)),
          params: { event: { date: Date.today, note: 'note', user_attributes: { name: 'User One', phone: 'Phone1'} } }
      end
    end

    assert_redirected_to events_url
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete event_url(events(:one))
    end

    assert_redirected_to events_url
  end

  # test "should show event" do
  #   get event_url(@event)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_event_url(@event)
  #   assert_response :success
  # end

  # test "should update event" do
  #   patch event_url(@event), params: { event: { datetime: @event.datetime, note: @event.note, service_id: @event.service_id, user_id: @event.user_id } }
  #   assert_redirected_to event_url(@event)
  # end

end
