class Slot < ApplicationRecord
  belongs_to :service
  has_many   :events

  enum status: [:inactive, :active]

  delegate :time_zone, to: :service

  default_scope { order(:hour, :min) }

  scope :on_date, ->(date) { where(day: date.wday) }

  def self.available_on_date(date)
    active_slots = active.on_date(date)
    active_slots.select { |slot| slot.available_on_date?(date) }
  end

  def available_on_date?(date)
    events.on_date(date).empty?
  end

  def event_on_date(date)
    events.find_by date: date
  end

  def display
    hour.to_s + ':' + min.to_s
  end
end
