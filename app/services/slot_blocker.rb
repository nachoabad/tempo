# TODO: Refactor and optimize
class SlotBlocker
  def initialize(blocker_params:, service:)
    @service = service
    @week    = blocker_params[:week].try :to_date
    @date    = blocker_params[:date].try :to_date
    @slot    = service.slots.find_by id: blocker_params[:slot]
  end

  def block!
    events_to_block.each {|event| event.update(status: 2, user: nil) }
  end

  def unblock!
    events_to_unblock.each {|event| event.destroy }
  end

  def display
    if @week
      @week.strftime('Semana %U, %Y')
    elsif @slot
      @slot.display + ', ' + I18n.l(@date)
    else
      I18n.l(@date)
    end
  end

  def unit
    if @week
      'toda la semana'
    elsif @slot
      'este horario'
    else
      'todo el día'
    end
  end

  def event
    @slot.try :event_on_date, @date 
  end

  private

  def events_to_block
    events = []
    if @date && @slot
      events << Event.create_or_find_by(date: @date, slot: @slot)
    elsif @date
      @service.slots.on_date(@date).each do |slot|
        events << Event.create_or_find_by(date: @date, slot: slot)
      end
    elsif @week
      (@week.beginning_of_week..@week.end_of_week).each do |date|
        @service.slots.on_date(date).each do |slot|
          events << Event.create_or_find_by(date: date, slot: slot)
        end
      end
    end
    events.compact
  end

  def events_to_unblock
    events = []
    if @date && @slot
      events << Event.find_by(date: @date, slot: @slot)
    elsif @date
      @service.slots.on_date(@date).each do |slot|
        events << Event.find_by(date: @date, slot: slot)
      end
    elsif @week
      (@week.beginning_of_week..@week.end_of_week).each do |date|
        @service.slots.on_date(date).each do |slot|
          events << Event.find_by(date: date, slot: slot)
        end
      end
    end
    events.compact
  end
end