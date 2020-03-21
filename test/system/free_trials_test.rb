require "application_system_test_case"

class FreeTrialsTest < ApplicationSystemTestCase
  setup do
    @free_trial = free_trials(:one)
  end

  test "visiting the index" do
    visit free_trials_url
    assert_selector "h1", text: "Free Trials"
  end

  test "creating a Free trial" do
    visit free_trials_url
    click_on "New Free Trial"

    fill_in "Contact time", with: @free_trial.contact_time
    fill_in "Email", with: @free_trial.email
    fill_in "Name", with: @free_trial.name
    fill_in "Phone", with: @free_trial.phone
    click_on "Create Free trial"

    assert_text "Free trial was successfully created"
    click_on "Back"
  end

  test "updating a Free trial" do
    visit free_trials_url
    click_on "Edit", match: :first

    fill_in "Contact time", with: @free_trial.contact_time
    fill_in "Email", with: @free_trial.email
    fill_in "Name", with: @free_trial.name
    fill_in "Phone", with: @free_trial.phone
    click_on "Update Free trial"

    assert_text "Free trial was successfully updated"
    click_on "Back"
  end

  test "destroying a Free trial" do
    visit free_trials_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Free trial was successfully destroyed"
  end
end
