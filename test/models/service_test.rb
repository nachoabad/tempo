require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test '#soonest_available_date' do
    assert_equal services(:one).soonest_available_date(Date.yesterday), Date.today
    assert_equal services(:one).soonest_available_date(Date.today), Date.today
    assert_equal services(:one).soonest_available_date(Date.tomorrow), Date.tomorrow
    assert_equal services(:one).soonest_available_date(Date.tomorrow + 1), Date.today + 7.days
  end

  test '#previous_available_date' do
    assert_nil    services(:one).previous_available_date(Date.yesterday)
    assert_nil    services(:one).previous_available_date(Date.today)
    assert_equal  services(:one).previous_available_date(Date.tomorrow), Date.today
    assert_equal  services(:one).previous_available_date(Date.tomorrow + 1), Date.tomorrow
  end
end
