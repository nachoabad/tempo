require 'test_helper'

class SlotBlockerTest < ActiveSupport::TestCase
  setup do
    @service = services(:slot_blocker_test)
  end

  test 'block a reserved event' do
    slot = slots(:week_start_reserved).id
    date = Date.today.beginning_of_week.to_s

    SlotBlocker.new(blocker_params: {slot: slot, date: date}, service: @service).block!
    assert events(:week_start_reserved).blocked?
  end
end
