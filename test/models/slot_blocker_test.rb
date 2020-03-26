require 'test_helper'

class SlotBlockerTest < ActiveSupport::TestCase
  setup do
    @service = services(:slot_blocker_test)
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
end
