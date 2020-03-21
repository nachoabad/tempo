require 'test_helper'

class FreeTrialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @free_trial = free_trials(:one)
  end

  test "should get new" do
    get new_free_trial_url
    assert_response :success
  end

  test "should create free_trial" do
    assert_difference('FreeTrial.count') do
      post free_trials_url, params: { free_trial: { contact_time: @free_trial.contact_time, email: @free_trial.email, name: @free_trial.name, phone: @free_trial.phone } }
    end

    assert_redirected_to root_path
  end
end
