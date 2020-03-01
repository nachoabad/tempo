class Slot < ApplicationRecord
  belongs_to :service

  delegate :time_zone, to: :service

  default_scope { order(:hour, :min) }
  scope :for_date, ->(date) { where(day: date.wday) }

  def self.available_for_date(date)
    slots = for_date(date)
  end

  #TODO: Move to presenter
  def display
    hour.to_s + ':' + min.to_s
  end
end
