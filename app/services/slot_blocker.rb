class SlotBlocker
  def initialize(blocker_params:, service:)
    @week    = blocker_params[:week]
    @date    = blocker_params[:date]
    @slot    = admin.slots.find_by id: blocker_params[:slot]
    @service = service
    @admin   = service.admin
  end

  def block!
    events.update_all(status: :blocked, user: nil)
  end

  def unblock!
    events.destroy_all
  end

  private

  def events
    event = []
    if @date && @slot
      events << @admin.events.create_or_find_by(date: @date, slot: @slot)
    elsif @date
      @service.slots.on_date(@date).each do |slot|
        events << @admin.events.create_or_find_by(date: @date, slot: slot)
      end
    elsif @week
      (@week.beginning_of_week..@week.end_of_week).each |date|
        @service.slots.on_date(date).each do |slot|
          events << @admin.events.create_or_find_by(date: date, slot: slot)
        end
      end
    end
    events
  end
end