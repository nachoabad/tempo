class Slot < ApplicationRecord
  belongs_to :service
  has_many   :events, dependent: :destroy

  enum status: [:inactive, :active]

  delegate :time_zone, to: :service

  default_scope { order(:hour, :min) }

  scope :on_date, ->(date) { where(day: date.wday) }

  #TODO: Optimize this
  def self.available_on_date(date)
    active_slots = active.on_date(date)
    available_slots = active_slots.select { |slot| slot.available_on_date?(date) }
    date.today? ? available_slots.select { |slot| slot.to_time > Time.current.localtime(slot.formatted_offset) } : available_slots
  end

  def available_on_date?(date)
    events.on_date(date).empty?
  end

  def event_on_date(date)
    events.find_by date: date
  end

  def display
    Time.new(1, 1, 1, hour, min).strftime('%l:%M%p')
  end

  def to_time
    current_time_in_zone = Time.current.localtime(formatted_offset)
    current_time_in_zone.change(hour: hour, min: min)
  end

  def formatted_offset
    ActiveSupport::TimeZone[time_zone].formatted_offset
  end
end
