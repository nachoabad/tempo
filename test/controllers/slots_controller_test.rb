require 'test_helper'

class SlotsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get service_slots_url(services(:one))
    assert_response :success
  end
end
