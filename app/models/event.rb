class Event < ApplicationRecord
  belongs_to :service
  belongs_to :user

  enum status: [:pending, :confirmed, :blocked]
  
  default_scope { order(:time) }
  scope :for_date, ->(date) { where(day: date.wday) }

end
