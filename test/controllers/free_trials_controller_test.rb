require 'test_helper'

class FreeTrialsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @free_trial = free_trials(:one)
  end

  test "should get index" do
    get free_trials_url
    assert_response :success
  end

  test "should get new" do
    get new_free_trial_url
    assert_response :success
  end

  test "should create free_trial" do
    assert_difference('FreeTrial.count') do
      post free_trials_url, params: { free_trial: { contact_time: @free_trial.contact_time, email: @free_trial.email, name: @free_trial.name, phone: @free_trial.phone } }
    end

    assert_redirected_to free_trial_url(FreeTrial.last)
  end

  test "should show free_trial" do
    get free_trial_url(@free_trial)
    assert_response :success
  end

  test "should get edit" do
    get edit_free_trial_url(@free_trial)
    assert_response :success
  end

  test "should update free_trial" do
    patch free_trial_url(@free_trial), params: { free_trial: { contact_time: @free_trial.contact_time, email: @free_trial.email, name: @free_trial.name, phone: @free_trial.phone } }
    assert_redirected_to free_trial_url(@free_trial)
  end

  test "should destroy free_trial" do
    assert_difference('FreeTrial.count', -1) do
      delete free_trial_url(@free_trial)
    end

    assert_redirected_to free_trials_url
  end
end
