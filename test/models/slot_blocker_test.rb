require 'test_helper'

class SlotBlockerTest < ActiveSupport::TestCase
  setup do
    Timecop.freeze(Date.today.beginning_of_day)
    @service = services(:slot_blocker_test)
  end

  teardown do
    next_week_events_remain_intact
  end

  test 'block a reserved event' do
    slot = slots(:week_start_reserved).id
    date = Date.today.beginning_of_week.to_s

    assert_difference('Event.count', 0) do
      SlotBlocker.new(blocker_params: {slot: slot, date: date}, service: @service).block!
    end
    assert events(:week_start_reserved).blocked?
  end

  test 'block an available slot' do
    slot = slots(:week_start_available).id
    date = Date.today.beginning_of_week.to_s

    assert_difference('Event.count', 1) do
      SlotBlocker.new(blocker_params: {slot: slot, date: date}, service: @service).block!
    end
    assert Event.unscoped.last.blocked?
  end

  test 'unblock a reserved event' do
    slot = slots(:week_start_reserved).id
    date = Date.today.beginning_of_week.to_s

    assert_not slots(:week_start_reserved).available_on_date?(date)
    assert_difference('Event.count', -1) do
      SlotBlocker.new(blocker_params: {slot: slot, date: date}, service: @service).unblock!
    end
    assert slots(:week_start_reserved).available_on_date?(date)
  end

  test 'unblock a block event' do
    slot = slots(:week_start_blocked).id
    date = Date.today.beginning_of_week.to_s

    assert_not slots(:week_start_blocked).available_on_date?(date)
    assert_difference('Event.count', -1) do
      SlotBlocker.new(blocker_params: {slot: slot, date: date}, service: @service).unblock!
    end
    assert slots(:week_start_blocked).available_on_date?(date)
  end

  test 'block a date' do
    date = Date.today.beginning_of_week

    assert_difference('Event.count', 1) do
      SlotBlocker.new(blocker_params: {date: date.to_s}, service: @service).block!
    end
    assert @service.slots.available_on_date(date).empty?
  end

  test 'unblock a date' do
    date = Date.today.beginning_of_week

    assert_difference('Event.count', -3) do
      SlotBlocker.new(blocker_params: {date: date.to_s}, service: @service).unblock!
    end
    assert_equal @service.slots.available_on_date(date).count, 3
  end

  test 'block a week' do
    date = Date.today

    assert_difference('Event.count', 2) do
      SlotBlocker.new(blocker_params: {week: date.to_s}, service: @service).block!
    end
    assert @service.slots.available_on_date(date.beginning_of_week).empty?
    assert @service.slots.available_on_date(date.end_of_week).empty?
  end

  test 'unblock a week' do
    date = Date.today

    assert_difference('Event.count', -6) do
      SlotBlocker.new(blocker_params: {week: date.to_s}, service: @service).unblock!
    end
    assert_equal @service.slots.available_on_date(date.beginning_of_week).count, 3
    assert_equal @service.slots.available_on_date(date.end_of_week).count, 3
  end

  private

  def next_week_events_remain_intact
    assert events(:next_week_start_reserved).confirmed?
    assert events(:next_week_start_blocked).blocked?
    assert events(:next_week_start_inactive).confirmed?
  end
end
