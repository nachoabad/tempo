require 'test_helper'

class SlotTest < ActiveSupport::TestCase
  setup do
    @service = services(:one)
  end

  test '.available_on_date' do
    Timecop.travel(Date.today.beginning_of_day)
    assert_equal @service.slots.available_on_date(Date.today), [slots(:today_8am)]
    assert_equal @service.slots.available_on_date(Date.tomorrow), [slots(:tomorrow_8am)]

    Timecop.travel(Date.today.end_of_day - 3.hours)
    assert_equal @service.slots.available_on_date(Date.today), []
    assert_equal @service.slots.available_on_date(Date.tomorrow), [slots(:tomorrow_8am)]
  end

  test '#available_on_date?' do
    assert slots(:today_8am).available_on_date?(Date.today)
    assert slots(:tomorrow_8am).available_on_date?(Date.tomorrow)
  end

  test '#event_on_date' do
    assert_not slots(:today_8am).event_on_date(Date.today)
    assert_not slots(:tomorrow_8am).event_on_date(Date.tomorrow)
  end
end
